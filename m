Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8212928F
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2019 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfLWHxt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Dec 2019 02:53:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39509 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLWHxt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Dec 2019 02:53:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so3924178plp.6
        for <linux-ext4@vger.kernel.org>; Sun, 22 Dec 2019 23:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YA1byZ0X3QxVQ8DhAKAhOXGjebNP768Lq7LIPfs+a8M=;
        b=Qaw+zjLEdB0acO8gimX6hByDh4IynKDGfbxIBJyByGTkOfi4JkU2BZ3n3sEnqkn7ok
         K2IvJjzNH1Ji18rnWJyU5OtEVEV1ZFj74Mi05tAGqvhxzogPp7Mbkc3g2xApBsHGiXqU
         gAyHmuKaiI+ubLyWRpOKowpEfJX51KiBL2aXQ6AmFY1XiPCofyqhShD+E89CW6Ny0XHb
         u+wB+3ykyjeJPSJ8m/1Smq0RWu7of91K23wqGUtK7GKP4pYUQri4UYHf3DakPpYnwqts
         Kax1OvpDlAP/YqYtaG9gp5SzKhrE9qaQi5tnEm9JfILLzuNry4Jw4u3vms8Nkyf9X8YN
         p5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YA1byZ0X3QxVQ8DhAKAhOXGjebNP768Lq7LIPfs+a8M=;
        b=GzMprY4mlXzIPo4RUBvKMzXXATC5XCcL6X7LYP0szOO34RUEDSB2MtvzWrCa4lv0Pj
         EZeuo8MGdWB1foCAdMONmnQEaaoYCx7SwJpSwUh6EEGRk9r+6j0KvF56zaGCzJuEuwJK
         eYYDudxUbueJM9D+lzjFuomVljV1AWcDg16purn3g4UQFw3vnyuYf6SAdAABCyNaabaI
         e0zvLFL3xLFv5rHegRxXCMbiRsA6xgRk8+iQq49bJ8MZqxtRSRp6ReJplMxuzDCFv2AQ
         O5YEabQGFnvvg50GKDKlgqAAG2MD8JgixF60NxSFv51cT/r/7k1J9TFJsRUzflbUY+Nh
         OMsw==
X-Gm-Message-State: APjAAAVGk9nIiYhRlJrzpr4PXK2CEL8Fdhtp/+QWiJerSjR+WshyiELh
        0QfHz3TVuGnATfIjJH0Nvfs=
X-Google-Smtp-Source: APXvYqwWAyMRGKGU+jAh1uomvxz3owAkg1N6N5xpW/fXa6KMEIYrVEJid41CaJCfpvCKp+2z+Y3I9g==
X-Received: by 2002:a17:90b:f0f:: with SMTP id br15mr32312044pjb.138.1577087628909;
        Sun, 22 Dec 2019 23:53:48 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m3sm18755277pfh.116.2019.12.22.23.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 23:53:48 -0800 (PST)
Date:   Mon, 23 Dec 2019 15:53:41 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: ensure revoke credits when set xattr
Message-ID: <20191223075341.wrg4xzn3vp3kugol@xzhoux.usersys.redhat.com>
References: <20191221105508.nrvonawwtz5a6bfz@xzhoux.usersys.redhat.com>
 <20191222020627.GA108990@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191222020627.GA108990@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Sat, Dec 21, 2019 at 09:06:27PM -0500, Theodore Y. Ts'o wrote:
> On Sat, Dec 21, 2019 at 07:34:28PM +0800, Murphy Zhou wrote:
> > It is possible that we need to release and forget blocks
> > during set xattr block, especially with 128 inode size,
> > so we need enough revoke credits to do that. Or we'll
> > hit WARNING since commit:
> > 	[83448bd] ext4: Reserve revoke credits for freed blocks
> > 
> > This can be triggered easily in a kinda corner case...
> 
> Thanks for reporting the problem.  However, your fix isn't quite
> correct.  The problem is that ext4_journal_ensure_credits() ultimately
> calls jbd2_journal_extend(), which has the following documentation.
> 
> /**
>  * int jbd2_journal_extend() - extend buffer credits.
>  * @handle:  handle to 'extend'
>  * @nblocks: nr blocks to try to extend by.
>  * @revoke_records: number of revoke records to try to extend by.
>  *
>  * Some transactions, such as large extends and truncates, can be done
>  * atomically all at once or in several stages.  The operation requests
>  * a credit for a number of buffer modifications in advance, but can
>  * extend its credit if it needs more.
>  *
>  * jbd2_journal_extend tries to give the running handle more buffer credits.
>  * It does not guarantee that allocation - this is a best-effort only.
>  * The calling process MUST be able to deal cleanly with a failure to
>  * extend here.
> 
> > +		error = ext4_journal_ensure_credits(handle, credits,
> > +				ext4_trans_default_revoke_credits(inode->i_sb));
> > +		if (error < 0) {
> > +			EXT4_ERROR_INODE(inode, "ensure credits (error %d)", error);
> > +			goto cleanup;
> > +		}
> 
> Calling ext4_error() is not dealing cleanly with failure; doing this
> is tricky (see how we do it for truncate) since some change may have
> already been made to the file system via the current handle, and
> keeping the file system consistent requires a lot of careful design
> work.

Thanks very much for the reviewing and explaination. Much appreciate!
I did not notice this and consider about this.

> 
> Fortunately, there's a simpler way to do this.  All we need to do is
> to do is to start the handle with the necessary revoke credits:
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 8966a5439a22..c4ae268d5dcb 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2475,7 +2475,8 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
>  	if (error)
>  		return error;
>  
> -	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
> +	handle = ext4_journal_start_with_revoke(inode, EXT4_HT_XATTR, credits,
> +			ext4_trans_default_revoke_credits(inode->i_sb));
>  	if (IS_ERR(handle)) {
>  		error = PTR_ERR(handle);
>  	} else {
> 
> The other problem is that I'm not able to reproduce the failure using
> your shell script.  What version of the kernel were you using, and was
> there any thing special needed to trigger the complaint?

I was using latest Linus tree, and nothing special is needed except
the 128 bit inode size, which requires to find new block.

Aha, after your tag "ext4_for_linus_stable" has been merged into Linus
tree, I can't reproduce it either.

I guess it's fixed by:
	a70fd5ac2ea7 yangerkun ext4: reserve revoke credits in __ext4_new_inode
Becuase the warning i hitting is also in __ext4_new_inode code path.

Thanks!
Xiong

> 
>       	  		       	  	  - Ted
