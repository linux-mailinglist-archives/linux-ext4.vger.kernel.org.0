Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77D46F646
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Dec 2021 22:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhLIV7H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Dec 2021 16:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhLIV7H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Dec 2021 16:59:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C40C061746
        for <linux-ext4@vger.kernel.org>; Thu,  9 Dec 2021 13:55:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c3so8348262iob.6
        for <linux-ext4@vger.kernel.org>; Thu, 09 Dec 2021 13:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=duaMlFwbQIr//xgiz9w0HxC+/4ToCvVkoMayY0Aw2tQ=;
        b=vCoCQysDVCZJzhLddt0BDC3Htmh3DJJJGsHtWAZ90Br/jntjoE92kb97ESTxg0eC9U
         zdj8y+W8djZKbMt3jp5R0WC9T0qPzdm5n97L3/KEQ1m6XGzlIe6EbINlTMzBwhKqBHDm
         a4AKF/CvWodYT+pRDJ1a8SNn4C1++yHKxs+8CgGrobeaoXAOMTVNnCoEiVKdnRpJZdRl
         eDbQzJ4BMBCcTkLWtkaGfEA3P8NGjQwF5Ef50VnRIVzGv4t2Uk4NwxThTTrnpLOxOfiJ
         YEcxg0BDlwjIfjxirot6dNx8M94j46rqT6NMY5Jvi67LfkFFJ/myjsB0QoP5pWbZ1wYF
         KH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=duaMlFwbQIr//xgiz9w0HxC+/4ToCvVkoMayY0Aw2tQ=;
        b=BxGFyvkcbaFCOc4qaXdFIkZ+PEB1Ft2WdTX2bzeVWAwAV7lQubOUDc7TYctGyenvIr
         rspDB4JWYtaXcw2SoP2unM4yAkPEU/mHhdtLsn7761XVJAOFKBVkes6b6jLUCL7HxYO4
         Qczxl9ri5VgrbWeDDHV7ZLO+0kH+Ex9/lOF3XdbygEs2+VfR1dYEehaaSkFZH+N2L9mh
         Nmd7vHSa/Inn6lk3uH78Oo2PwDIiO38Asc+3yn0AvRbuYI7TEqvmjnt38GlrX9TthJJC
         VUuJ0lTxIfKLWKRK1KhoztxOV+nGLYZse1tA8jryzlcTUdcr2zS1U5FyUNLR+GhL3egl
         Z35Q==
X-Gm-Message-State: AOAM533YkAVroDy6NglLPb9wNmWrpb3yHog6PCXTEI7UI8TLQsYNZxtq
        oWHj/Uw5qq6kUtkt/hlJfdTf/Q==
X-Google-Smtp-Source: ABdhPJxFlNaThHNftjqnYu8cgQLqDWT0fpi80aov5NQRq+E6+SVjAUlhcxcI3WqmHjJeyOfSTkX9Bg==
X-Received: by 2002:a6b:7f04:: with SMTP id l4mr18033063ioq.62.1639086932356;
        Thu, 09 Dec 2021 13:55:32 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s18sm578607ilq.25.2021.12.09.13.55.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:55:30 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <07CD099E-959E-4F85-B7B6-72F025E64545@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_59383CD9-7DF2-4B3F-AFD6-F3C7FA13A9C8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: map PROMPT_* values to prompt messages
Date:   Thu, 9 Dec 2021 14:55:26 -0700
In-Reply-To: <20211208164238.GA69182@magnolia>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20211208075112.85649-1-adilger@dilger.ca>
 <20211208164238.GA69182@magnolia>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_59383CD9-7DF2-4B3F-AFD6-F3C7FA13A9C8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 8, 2021, at 9:42 AM, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> On Wed, Dec 08, 2021 at 12:51:12AM -0700, Andreas Dilger wrote:
>> It isn't totally clear when searching the code for PROMPT_*
>> constants from problem codes where these messages come from.
>> Similarly, there isn't a direct mapping from the prompt string
>> to the constant.
>> 
>> Add comments that make this mapping more clear.
>> 
>> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
>> ---
>> e2fsck/problem.c | 46 +++++++++++++++++++++++-----------------------
>> 1 file changed, 23 insertions(+), 23 deletions(-)
>> 
>> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
>> index 757b5d56..2d02468c 100644
>> --- a/e2fsck/problem.c
>> +++ b/e2fsck/problem.c
>> @@ -50,29 +50,29 @@
>>  * to fix a problem.
>>  */
>> static const char *prompt[] = {
>> -	N_("(no prompt)"),	/* 0 */
>> -	N_("Fix"),		/* 1 */
>> -	N_("Clear"),		/* 2 */
>> -	N_("Relocate"),		/* 3 */
>> -	N_("Allocate"),		/* 4 */
>> -	N_("Expand"),		/* 5 */
>> -	N_("Connect to /lost+found"), /* 6 */
>> -	N_("Create"),		/* 7 */
>> -	N_("Salvage"),		/* 8 */
>> -	N_("Truncate"),		/* 9 */
>> -	N_("Clear inode"),	/* 10 */
>> -	N_("Abort"),		/* 11 */
>> -	N_("Split"),		/* 12 */
>> -	N_("Continue"),		/* 13 */
>> -	N_("Clone multiply-claimed blocks"), /* 14 */
>> -	N_("Delete file"),	/* 15 */
>> -	N_("Suppress messages"),/* 16 */
>> -	N_("Unlink"),		/* 17 */
>> -	N_("Clear HTree index"),/* 18 */
>> -	N_("Recreate"),		/* 19 */
>> -	N_("Optimize"),		/* 20 */
>> -	N_("Clear flag"),	/* 21 */
>> -	"",			/* 22 */
>> +	N_("(no prompt)"),			/* PROMPT_NONE		=  0 */
> 
> Why not make it even clearer and mismerge proof:
> 
> static const char *prompt[] = {
> 	[0]		= N_("(no prompt")),	/* null value test */
> 	[PROMPT_FIX]	= N_("Fix"),		/* 1 */
> 	[PROMPT_CLEAR]	= N_("Clear"),		/* 2 */
> 	...
> };

I thought about that too, but then I thought the "[index] = foo" designated
initializer is GNU or at least C99-specific, and I wondered if that was
going to cause portability problems for some ancient system that e2fsprogs
is building on...  I figured adding comments is relatively safe, and these
values change so rarely that more complexity in the patch was not a win.

Cheers, Andreas






--Apple-Mail=_59383CD9-7DF2-4B3F-AFD6-F3C7FA13A9C8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGye08ACgkQcqXauRfM
H+BHzA/+KBDpbQTyEGmYaxfX7bkECnadLg5zA4R3S1lK/1NFhopYgNN9h8Pxr7ry
X/4HHOAnmjFkJsl22FpcctKiMI5XMxJFFkdKzkw7uuy8/Diuhdue7Olcbovpf5fi
cVzmgl4c6fX4PffIaQuKVh9TMBxwgWL9KzRlPic0PmCzp7lZr1+mznPQnvIXxCis
REWgcRx+pOHKKFZXcOY32XkL5Ryj+ypYOs8WWP8luqPstsHKIMBokd/lbt3do/no
5H/aM9lx3pjGuclm8dg1XTjOm/7HjXDmiKWw+2M9jL/0NBRBO5y7/nOZCq4h5Emo
iUlaPe8+LT72iAXnu8vjqMhkvr1tdIWjDYAehj8cz4yoWlKml+1ZE0QfqHJL9voW
sQjzKdVMuRyEJW3dNdtimXeaOR5JJYXh9tUQL+5qkQoDpMaJqFgcxu9UXNwjsUQl
LBRM2ipKblkn4x1j2Ok0HaY0Fx2yiOPbey4Z7kZGaMbm+RJvuQudLagY+uRAH2dF
GPoJW01VxYfCjYcILBX3iUREb2beHWFdlhEFb4/zantYSCtEL351H+blf4Gbb4+7
puCN2nBhLQQwSnvsySLOzVkZbnwr0pJgQTDUMXCs2hr+2uTUf58JGN0dclHhMXZT
9MlsyVddvfIU3MHnKDMNi7mIb4hVrwNIQAgmKCVp0pypWdr+B40=
=CbFB
-----END PGP SIGNATURE-----

--Apple-Mail=_59383CD9-7DF2-4B3F-AFD6-F3C7FA13A9C8--
