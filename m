Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1356354B3D
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 05:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbhDFDeq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Apr 2021 23:34:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46077 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233879AbhDFDep (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Apr 2021 23:34:45 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1363YRMW016082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Apr 2021 23:34:28 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 854A515C3399; Mon,  5 Apr 2021 23:34:27 -0400 (EDT)
Date:   Mon, 5 Apr 2021 23:34:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
Message-ID: <YGvWwx/+HMdWMJwT@mit.edu>
References: <20210325022925.1769056-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325022925.1769056-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 25, 2021 at 10:29:25AM +0800, Ye Bin wrote:
> We got follow bug_on:
> [130747.323114] kernel BUG at fs/ext4/extents_status.c:762!
> [130747.323117] Internal error: Oops - BUG: 0 [#1] SMP
> ......
> [130747.334329] Call trace:
> [130747.334553]  ext4_es_cache_extent+0x150/0x168 [ext4]
> [130747.334975]  ext4_cache_extents+0x64/0xe8 [ext4]
> [130747.335368]  ext4_find_extent+0x300/0x330 [ext4]
> [130747.335759]  ext4_ext_map_blocks+0x74/0x1178 [ext4]
> [130747.336179]  ext4_map_blocks+0x2f4/0x5f0 [ext4]
> [130747.336567]  ext4_mpage_readpages+0x4a8/0x7a8 [ext4]
> [130747.336995]  ext4_readpage+0x54/0x100 [ext4]
> [130747.337359]  generic_file_buffered_read+0x410/0xae8
> [130747.337767]  generic_file_read_iter+0x114/0x190
> [130747.338152]  ext4_file_read_iter+0x5c/0x140 [ext4]
> [130747.338556]  __vfs_read+0x11c/0x188
> [130747.338851]  vfs_read+0x94/0x150
> [130747.339110]  ksys_read+0x74/0xf0
> 
> If call ext4_ext_insert_extent failed but new extent already inserted, we just
> update "ex->ee_len = orig_ex.ee_len", this will lead to extent overlap, then
> cause bug on when cache extent.

How did this happen in the first place?  It sounds like if the extent
was already inserted, that would be casue there was an on-disk file
system corruption, no?

In that case, shouldn't we call ext4_error() to declare the file
system has an inconsistency, so it can be fixed by fsck?

> If call ext4_ext_insert_extent failed don't update ex->ee_len with old value.
> Maybe there will lead to block leak, but it can be fixed by fsck later.

  	      	   	   	       - Ted
