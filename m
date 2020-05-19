Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2499E1D8D4F
	for <lists+linux-ext4@lfdr.de>; Tue, 19 May 2020 03:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgESBzn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 May 2020 21:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgESBzm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 May 2020 21:55:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A572C061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 18 May 2020 18:55:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f4so5670733pgi.10
        for <linux-ext4@vger.kernel.org>; Mon, 18 May 2020 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s7J5+T5gveCZ5Fjvf/60JxkQZzKjzSNJ0WQ+awcbRx0=;
        b=X0OWwgIypYJ1cn2DCHIcT51ZtRmdoZJXv0dQrk5SYU0+sn9oeovKhcSGbLipwB/Sts
         KFXvqkDtSgAl3+RiiTPbIkZdCGaYul/rbjuWXR+557ClinJ9u2T7+uN2fHE/wmNbc4P3
         NAK4ZpovYIwgzxXUnEcnplCn3vGnHuAmHSgdZIfyOnECbr+Ny0rag2Rp1REH80tKkNuf
         v182oZe2uWnNIUTQvfNGTN7oxOvwmAoXV5n/U+M9S45ZdwBRHMt1QBvx9eHDXHLUiEgN
         eIWV/xpF3iEzg2wFQt4/a3ptTWS13GySnw5aj+4gXh32izdnD0duteTvr4TdvDD2G6TZ
         F0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s7J5+T5gveCZ5Fjvf/60JxkQZzKjzSNJ0WQ+awcbRx0=;
        b=n5He8tF+EIWRdW9S58RmAh0BimSvEwZ1aDI1NLpby14LGYsvNQ1U82lFAQLON/jR6P
         MMDggsCqtYZzGtg7FW+ODbyL68xSZ28dhT7aK804n4eR0Bl1WHHyUYCgcZB74rsm3EWS
         iF5pSs6nxruvWJFey/wfVTfvvmuuBe6wcgKS24sHzQJxqIzBNb/Sv1NlxV3fgla9ii6X
         ynzUknCpltyq7nEC8KGf5dv/P3h8PL+ORG2L78nvx5pOYDndTZLEwFdju0aA6zblxbry
         VrBNk1G09Iopdw34gEnS1xvN/7M+g4/4mjhdy8aNesjSKCbIcOKYH7CZJv2By1MgL4Lw
         X3pg==
X-Gm-Message-State: AOAM532JJrfLa7DMoYFxng1RTXAF0bDpp+ZJJ3MCZlXTM32+EfagYsKv
        6OdlCxJNT+0iZSGcQMjRi6Xqk4kYA3sB+Q==
X-Google-Smtp-Source: ABdhPJy0uJzHhxHn+xAbERRW8aveOLTVnvKnqSKLmGJuXP5Bs1durqqi7CCNiisCAgMcevRq1YwkXw==
X-Received: by 2002:a65:51c1:: with SMTP id i1mr17321717pgq.272.1589853340622;
        Mon, 18 May 2020 18:55:40 -0700 (PDT)
Received: from [192.168.15.102] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id e26sm6063448pff.137.2020.05.18.18.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 18:55:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] ext4: Drop ext4_journal_free_reserved()
Date:   Mon, 18 May 2020 19:55:38 -0600
Message-Id: <E3625DCE-DC39-4977-9A47-AE1FBD14CB0D@dilger.ca>
References: <20200518092120.10322-2-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
In-Reply-To: <20200518092120.10322-2-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: iPhone Mail (17E262)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On May 18, 2020, at 03:21, Jan Kara <jack@suse.cz> wrote:
>=20
> =EF=BB=BFRemome ext4_journal_free_reserved() function. It is never used.

(typo) "Remove", but otherwise seems fine.

> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


> ---
> fs/ext4/ext4_jbd2.h | 6 ------
> 1 file changed, 6 deletions(-)
>=20
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 4b9002f0e84c..1c926f31d43e 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -335,12 +335,6 @@ static inline handle_t *__ext4_journal_start(struct i=
node *inode,
> handle_t *__ext4_journal_start_reserved(handle_t *handle, unsigned int lin=
e,
>                    int type);
>=20
> -static inline void ext4_journal_free_reserved(handle_t *handle)
> -{
> -    if (ext4_handle_valid(handle))
> -        jbd2_journal_free_reserved(handle);
> -}
> -
> static inline handle_t *ext4_journal_current_handle(void)
> {
>    return journal_current_handle();
> --=20
> 2.16.4
>=20
