Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663C51493F3
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 09:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAYIBB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 03:01:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58652 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgAYIBB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 03:01:01 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P80jmq032238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 03:00:48 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 209C742014A; Sat, 25 Jan 2020 03:00:45 -0500 (EST)
Date:   Sat, 25 Jan 2020 03:00:45 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        jack@suse.com, adilger.kernel@dilger.ca, liangyun2@huawei.com,
        luoshijie1@huawei.com
Subject: Re: [PATCH v3 3/4] jbd2: make sure ESHUTDOWN to be recorded in the
 journal superblock
Message-ID: <20200125080045.GK1108497@mit.edu>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
 <20191204124614.45424-4-yi.zhang@huawei.com>
 <20191204170528.GH8206@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204170528.GH8206@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 04, 2019 at 06:05:28PM +0100, Jan Kara wrote:
> On Wed 04-12-19 20:46:13, zhangyi (F) wrote:
> > Commit fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer") want
> > to allow jbd2 layer to distinguish shutdown journal abort from other
> > error cases. So the ESHUTDOWN should be taken precedence over any other
> > errno which has already been recoded after EXT4_FLAGS_SHUTDOWN is set,
> > but it only update errno in the journal suoerblock now if the old errno
> > is 0.
> > 
> > Fixes: fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer")
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> Yeah, I think this is correct if I understand the logic correctly but I'd
> like Ted to have a look at this. Anyway, feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Yep, this looks sane.  Thanks, applied.

				- Ted
