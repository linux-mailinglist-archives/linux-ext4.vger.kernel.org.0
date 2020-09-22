Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C7273F93
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Sep 2020 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIVK0Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Sep 2020 06:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgIVK0M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Sep 2020 06:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600770371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NP/X/94HMNHmoH8pDhuasSnOzlYoWVoVVECd1n6tkiA=;
        b=Ra//y8OLuH1mu3T8+6Cu+crkL+xMpRmHSDiim0aAHTwQytURFFonPNJR56Kz1Yfbp8wSQ7
        dEIRV+tlPdKVlcUOmoeVSwOkjGzBTWFD31Xl1pldgIYvHrm+3IYH60qaoLFUk2hgixusQD
        T+oCgmhhKlcSpvx3aHZ/2SrP5lY0klg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-MM77Emd4ORiMngXLNOc_hA-1; Tue, 22 Sep 2020 06:26:07 -0400
X-MC-Unique: MM77Emd4ORiMngXLNOc_hA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EE7E807333;
        Tue, 22 Sep 2020 10:26:06 +0000 (UTC)
Received: from work (unknown [10.40.195.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89DB07366B;
        Tue, 22 Sep 2020 10:26:04 +0000 (UTC)
Date:   Tue, 22 Sep 2020 12:26:00 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     adilger@whamcloud.com
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] e2fsck: skip extent optimization by default
Message-ID: <20200922102600.5asdjvarnh5znhf2@work>
References: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 21, 2020 at 04:16:02PM -0600, adilger@whamcloud.com wrote:
> From: Andreas Dilger <adilger@whamcloud.com>
> 
> The e2fsck error message:
> 
>     inode nnn extent tree (at level 1) could be narrower. Optimize<y>?
> 
> can be fairly verbose at times, and leads users to think that there
> may be something wrong with the filesystem.  Basically, almost any
> message printed by e2fsck makes users nervous when they are facing
> other corruption, and a few thousand of these printed may hide other
> errors.  It also isn't clear that saving a few blocks optimizing the
> extent tree noticeably improves performance.
> 
> This message has previously been annoying enough for Ted to add the
> "-E no_optimize_extents" option to disable it.  Just enable this
> option by default, similar to the "-D" directory optimization option.

Hi Andreas,

it seem counterproductive to me that we would disable usefull (even if
just a little) optimization just because the way it is presented to the
user is inconvenient. I agree that messages during e2fsck often raise
alarms, as they should, but perfeps instead of disabling the feature we
can figure out a way to make the messaging better ?

Can we just not print the every message if the answer is going to be yes
anyway, either because of -y, -p, <a> or whatever when the user is not
involved in the decision anymore ? Maybe a log file can be created
for the purpose of storing the full log of changes. Or perhaps we can
print out a summary for each type of the problem and how many of the
instaces of a particular problem have been optimized/fixed after the
e2fsck is done pointing to that full log for details ?

-Lukas

> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> ---
>  e2fsck/e2fsck.8.in | 4 ++--
>  e2fsck/unix.c      | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/e2fsck/e2fsck.8.in b/e2fsck/e2fsck.8.in
> index 4e3890b..4f5086a 100644
> --- a/e2fsck/e2fsck.8.in
> +++ b/e2fsck/e2fsck.8.in
> @@ -228,12 +228,12 @@ exactly the opposite of discard option. This is set as default.
>  .TP
>  .BI no_optimize_extents
>  Do not offer to optimize the extent tree by eliminating unnecessary
> -width or depth.  This can also be enabled in the options section of
> +width or depth.  This is the default unless otherwise specified in
>  .BR /etc/e2fsck.conf .
>  .TP
>  .BI optimize_extents
>  Offer to optimize the extent tree by eliminating unnecessary
> -width or depth.  This is the default unless otherwise specified in
> +width or depth.  This can also be enabled in the options section of
>  .BR /etc/e2fsck.conf .
>  .TP
>  .BI inode_count_fullmap
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index 1b7ccea..445f806 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -840,6 +840,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>  	else
>  		ctx->program_name = "e2fsck";
>  
> +	ctx->options |= E2F_OPT_NOOPT_EXTENTS;
> +
>  	phys_mem_kb = get_memory_size() / 1024;
>  	ctx->readahead_kb = ~0ULL;
>  	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
> @@ -1051,6 +1053,11 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>  	if (c)
>  		ctx->options |= E2F_OPT_NOOPT_EXTENTS;
>  
> +	profile_get_boolean(ctx->profile, "options", "optimize_extents",
> +			    0, 0, &c);
> +	if (c)
> +		ctx->options &= ~E2F_OPT_NOOPT_EXTENTS;
> +
>  	profile_get_boolean(ctx->profile, "options", "inode_count_fullmap",
>  			    0, 0, &c);
>  	if (c)
> -- 
> 1.7.12.4
> 

