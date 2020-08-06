Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D384E23D638
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 06:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHFE43 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 00:56:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44897 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725272AbgHFE43 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 00:56:29 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0764uMDG022041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 00:56:23 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 702E1420263; Thu,  6 Aug 2020 00:56:22 -0400 (EDT)
Date:   Thu, 6 Aug 2020 00:56:22 -0400
From:   tytso@mit.edu
To:     Yi Zhuang <zhuangyi1@huawei.com>
Cc:     <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: lost matching-pair of trace in ext4_unlink
Message-ID: <20200806045622.GE7657@mit.edu>
References: <20200629122621.129953-1-zhuangyi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629122621.129953-1-zhuangyi1@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 29, 2020 at 08:26:21PM +0800, Yi Zhuang wrote:
> If dquot_initialize() return non-zero and trace of ext4_unlink_enter/exit
> enabled then the matching-pair of trace_exit will lost in log.
> 
> v2:
> Change the new label to be "out_trace:", which makes it more clear that
> it is undoing the "trace" part of the code. At the same time, fix other
> similar problems in this function:
> 
> 	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
> 	if (IS_ERR(bh))
> 		return PTR_ERR(bh);
> 	if (!bh)
> 		goto end_unlink;
> 
> According to Andreas' suggestion, split up the "end_unlink:" label becomes
> two separate labels, and then remove the "if (handle)" check, and then
> use out_bh: before the handle is started.
> 
> Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>

Thanks, applied.

					- Ted
