Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D499426650
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 11:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhJHJEf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Oct 2021 05:04:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28900 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhJHJEd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Oct 2021 05:04:33 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQhtF23zPzbn07;
        Fri,  8 Oct 2021 16:58:13 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 17:02:37 +0800
Message-ID: <e3250b22-afda-04b9-76b3-ed50f2d52f1f@huawei.com>
Date:   Fri, 8 Oct 2021 17:02:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH 2/3] ext4: check for inconsistent extents between
 index and leaf block
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <yukuai3@huawei.com>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
 <20210908120850.4012324-3-yi.zhang@huawei.com> <YV8iTPcMBUQN80Ob@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <YV8iTPcMBUQN80Ob@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/10/8 0:37, Theodore Ts'o wrote:
> On Wed, Sep 08, 2021 at 08:08:49PM +0800, Zhang Yi wrote:
>> Now that we can check out overlapping extents in leaf block and
>> out-of-order index extents in index block. But the .ee_block in the
>> first extent of one leaf block should equal to the .ei_block in it's
>> parent index extent entry.
> 
> I don't believe this is always guaranteed.
> 
> The punch hole operation can remove some or part of the first entry in
> the leaf block, and it won't update the parent index.  So it's OK for
> the first entry of the leaf block to be greater than entry in the
> parent block.  However, if the first entry of the leaf block is less
> than the entry in the parent block, that's definitely going to be a
> problem.
> 

Hi, Ted.

ext4_punch_hole()->ext4_ext_remove_space()->ext4_ext_rm_leaf() call
ext4_ext_correct_indexes() or ext4_ext_rm_idx() to update the parent index
if the removing extent entry is the first entry of the leaf block.

static int
ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
                 struct ext4_ext_path *path,
                 struct partial_cluster *partial,
                 ext4_lblk_t start, ext4_lblk_t end)
{
...
                if (ex == EXT_FIRST_EXTENT(eh)) {
                        correct_index = 1;
...
        if (correct_index && eh->eh_entries)
                err = ext4_ext_correct_indexes(handle, inode, path);
...
}

static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
                        struct ext4_ext_path *path, int depth)
{
...
        while (--depth >= 0) {
...
                path->p_idx->ei_block = (path+1)->p_idx->ei_block;
...
        }
...
}

And the fsck does also check the mismatch case in scan_extent_node(), am I
missing something?

Thanks,
Yi.
