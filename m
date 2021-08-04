Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6CF3E00F5
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhHDMQH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 08:16:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36640 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbhHDMQG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 08:16:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AC46A221FB;
        Wed,  4 Aug 2021 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628079353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVmXaYlTb0OGHOFa/x8meGIUYZV4TA0GIgteDmhzhec=;
        b=g+XkvOnppqtNe9tfvLaTEoAN3Pw5yFU8FXLAp2vYye/AQ80S8+DCgk1o9EKxPgNwaaqXkz
        yWEpIP7t1dSkXKyrSHZvx9779qeCfuUFiXfuCYPx9P2wh0MItNCh/+GOsoOb+6gICo4hwD
        xRRAwmiweK5jA7wxkGbH/X70UCpnTLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628079353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVmXaYlTb0OGHOFa/x8meGIUYZV4TA0GIgteDmhzhec=;
        b=r2fCFiizM0DOblxNG+YRAgDtKJNpuGB02lL+XiWGOe9qUFuORy5djtg5xaIdVcrgi0O5vv
        wcAHT25XOwJfRvDg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 9E9F5A3B8C;
        Wed,  4 Aug 2021 12:15:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F49E1E62D6; Wed,  4 Aug 2021 14:15:53 +0200 (CEST)
Date:   Wed, 4 Aug 2021 14:15:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/9] quota: Do not account space used by project quota
 file to quota
Message-ID: <20210804121553.GC4578@quack2.suse.cz>
References: <20210616105735.5424-1-jack@suse.cz>
 <20210616105735.5424-3-jack@suse.cz>
 <YQlrGbFgxf8BYruB@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQlrGbFgxf8BYruB@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 03-08-21 12:13:13, Theodore Ts'o wrote:
> On Wed, Jun 16, 2021 at 12:57:28PM +0200, Jan Kara wrote:
> > Project quota files have high inode numbers but are not accounted in
> > quota usage. Do not track them when computing quota usage.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Thanks, applied to the maint branch (since this is a bug fix unrelated
> to the orhpan inode feature).
> 
> It looks like this was an issue that wasn't picked up by our
> regression tests.  Do you have an sample image that you used while you
> were developing this patch, that perhaps we should be adding to our
> regression test suite?

So I've uncovered this just by code inspection when adding orphan file
feature. Checking this problem is not as simple as using a fs image (the
problem manifests only if we add new quota type using tune2fs). I've
created a test for it. I'll post it separately.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
