Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04CF1493F1
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 08:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAYH75 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 02:59:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58434 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgAYH75 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 02:59:57 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P7xfgq032048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 02:59:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A8CAF42014A; Sat, 25 Jan 2020 02:59:40 -0500 (EST)
Date:   Sat, 25 Jan 2020 02:59:40 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        jack@suse.com, adilger.kernel@dilger.ca, liangyun2@huawei.com,
        luoshijie1@huawei.com
Subject: Re: [PATCH v3 2/4] ext4, jbd2: ensure panic when aborting with zero
 errno
Message-ID: <20200125075940.GJ1108497@mit.edu>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
 <20191204124614.45424-3-yi.zhang@huawei.com>
 <20191204125213.GG8206@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204125213.GG8206@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 04, 2019 at 01:52:13PM +0100, Jan Kara wrote:
> On Wed 04-12-19 20:46:12, zhangyi (F) wrote:
> > JBD2_REC_ERR flag used to indicate the errno has been updated when jbd2
> > aborted, and then __ext4_abort() and ext4_handle_error() can invoke
> > panic if ERRORS_PANIC is specified. But if the journal has been aborted
> > with zero errno, jbd2_journal_abort() didn't set this flag so we can
> > no longer panic. Fix this by always record the proper errno in the
> > journal superblock.
> > 
> > Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
