Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB38297980
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Oct 2020 01:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758511AbgJWXKw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758509AbgJWXKv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 19:10:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F05C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:10:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g16so44029pjv.3
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=hDLcCYZE9AimK+qDjAaZNexawhrcuN5x80EZlsiTSts=;
        b=Wd6puZWYUn5Ucr+n9+ZMUbSmrIEppfjRI+BkZNEYmqW1NLVqAeSoI9fnzDZJCwuCEf
         p34U1LMOEH5PFiRn6b5jVdTGgx4Fi73WSHh3NDngZ7Rx8BaMarMehj/hBP7Y2UKufraQ
         NHQUthvSJNpAKjlVRdwLNjTIim+ilzpUX/usctnKw45wo1H5fYro6uiZeH2VL8DP/AUs
         g5Flk9BGme+1P7vhBnOc9vo6DOdMUEBAktxlqguP+HgaD0I/VLZk8nG7KyeMlu0RZ2AI
         n7sfdzxWJVrMkwq/UP1yAU8ZTf+pfHKabxp8KDj6cYq40k4N4Xix+uW37WMEBj4Sd820
         mpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=hDLcCYZE9AimK+qDjAaZNexawhrcuN5x80EZlsiTSts=;
        b=pI+dFDPNNHxLOkj6zCeirtTios415Ez/2SAPU/APIXIta1vKDR3Xp/Ih3tVg+/ihWF
         FRQvVj8uaFnMx/oCVADaAgb333FF4SLPY6AVVQReNV+VcUN6jc8OsUtc3DL0d2hp8/XQ
         u5JD3qT0PRieGO1CXyyYU26tEXrWGGFUUMUfO5uUJJ5KdZormAPZeIPRU2jmkH6WBOtA
         WpA2wlqo1OsTqjjDpxuprP5qBphw027IztJ5zhS5VQjztEzekwUob5oASqgmUabF0Pga
         htiu2mwFy3FS2HsoSS9fhLyxfnOJY3+NRU4vyJUTMyW51aB6QFNwgW5IMtr3rjx8RRzx
         xDRw==
X-Gm-Message-State: AOAM531BAgNowzIMihJs6Mv4BjRUuDYLP1S9QF5YEw6W5WKWWXnVZjHe
        tgOm4h3uSKBtSgFoPg5V39kEig==
X-Google-Smtp-Source: ABdhPJwWwgLSMIb0N/nxCxo8XFWy/YZpwJLGw7Vlp90z6hj3/kS21bo5/4kWGOE3xkwODccJ9zEm9g==
X-Received: by 2002:a17:902:9347:b029:d3:7c08:86c6 with SMTP id g7-20020a1709029347b02900d37c0886c6mr4290654plp.84.1603494649749;
        Fri, 23 Oct 2020 16:10:49 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i24sm3204797pfd.7.2020.10.23.16.10.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 16:10:49 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <76E661D8-8A67-4588-AD05-64456F51B14D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7DC0E192-C04F-423D-9B08-FCFE6726C64A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 7/8] ext4: delete invalid code inside
 ext4_xattr_block_set()
Date:   Fri, 23 Oct 2020 17:10:47 -0600
In-Reply-To: <1603271728-7198-7-git-send-email-brookxu@tencent.com>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Chunguang Xu <brookxu.cn@gmail.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
 <1603271728-7198-7-git-send-email-brookxu@tencent.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7DC0E192-C04F-423D-9B08-FCFE6726C64A
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 21, 2020, at 3:15 AM, Chunguang Xu <brookxu.cn@gmail.com> wrote:
> 
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Delete invalid code inside ext4_xattr_block_set().
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

I would maybe write "inactive code", but seems OK either way

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/xattr.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 6127e94..4e3b1f8 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1927,7 +1927,6 @@ struct ext4_xattr_block_find {
> 	} else {
> 		/* Allocate a buffer where we construct the new block. */
> 		s->base = kzalloc(sb->s_blocksize, GFP_NOFS);
> -		/* assert(header == s->base) */
> 		error = -ENOMEM;
> 		if (s->base == NULL)
> 			goto cleanup;
> --
> 1.8.3.1
> 


Cheers, Andreas






--Apple-Mail=_7DC0E192-C04F-423D-9B08-FCFE6726C64A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+TYvcACgkQcqXauRfM
H+A1ew/9GiN6RrtQDt94ypl7TV2HFOa77DuSeXDv5ayXKFFYha9WwUWnbR4MyH1p
E1FrJX/qRoFRZIKSQTy6kEvX7+fqv9cy6fhaORUyxFmq5MxEy4QO7VQRidqGrf2N
74pVRynhTSs/8ReyElKXhfa89jBA1U1hCTd1T1L1ffjWOe81JwdlQeT4VK79ilIl
M0TvvFvzoYF/5SydvOrfKlfqfiibc0JfZlKAI06CVl0O0RcTtQM7RtvpGm9DPXsb
tcSsUUWyRbPJx7RFCJXNhxbjZsTOOp3bEzt4JAhEiwDO+R/oYSsXt9F2Eg+ph1fo
7advRlUbWp14/21xG6edZv/l1GJ6jdq/SbB6GktwN7/jiuB+gGIkyECWH7WK0GyM
80WO6bKz7FyzDmu59scilC/E16v3RAo6mlRwthryk8RJtEDxdRsBvYPMz7WsF13y
/HwgCX+7ac+LL5m7Xr8pR3OtwhSf69TimjJwZSCEuTKJonWh9CULGU/FwHeta0py
oGLxe0PT/z1odQen6FSU7ZL+XABZrF1wYr8hBJf0ytAuB2lBtwt65sg52YXe2eZL
Tw7NyYiR7SMOaCoVcz/Csr4o//RiSra1QeY3igeOJDtH1U2YAN7MBG9x/Dl53LM8
kK2j9N+s/FBsuxAxIG7J4nOaY9UHO9EbJFVeWU7kzkkcsrLQyr0=
=rOWT
-----END PGP SIGNATURE-----

--Apple-Mail=_7DC0E192-C04F-423D-9B08-FCFE6726C64A--
