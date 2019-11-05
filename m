Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53641EF247
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 01:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfKEAzA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 19:55:00 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50884 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729916AbfKEAy7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 19:54:59 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA50swoG017152
        for <linux-ext4@vger.kernel.org>; Mon, 4 Nov 2019 19:54:58 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA50srmg023006
        for <linux-ext4@vger.kernel.org>; Mon, 4 Nov 2019 19:54:58 -0500
Received: by mail-qk1-f197.google.com with SMTP id p68so19648804qkf.9
        for <linux-ext4@vger.kernel.org>; Mon, 04 Nov 2019 16:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=f2xKui4jCV1oC4mz8c3C4oOoH3JHAT+nc4LWmlpw1MY=;
        b=IklWEbimGaJRRQ1X94sHWLpzMBOb8/Hz66mmIzXYTS80QtttFd3GsMaJEwS1zNPN3v
         rxS/S6GbWMGf8hRi4OzCe3vjHeQvJw60zP/YYesgaFsmVPCOtpGaVO0ygcYHUjzsnnQ5
         fe0iCdVhX5SIEV779fhBr11iU8T4rAGLl/2/oZyGDzAA94+3NbueHNET19qrfbUosRj0
         RT4/F5WlHd7aZILaYkCjVEz4XKorgJTnN7OBl13E+Fo/R22SqNcwPSRqAyYncNUmVG7e
         7GlasvLEiFAxTM0rgAcd9wznWb1sNjklbkUuUSpFqb2W53AyEx6JR7kU0AuQ3+75rckt
         19Yg==
X-Gm-Message-State: APjAAAVXLppMmS5B15B4VhUkwPDfJptqOuq8mjVfaS6/K7D+QEaRpu8j
        uCH2GmZtE3iyA4jKJiimPAitNr9iFeyoz5g783/tlWBo4DiyjBVc2gQte+GbM44CMXbcZqaXTzG
        X3LW878cdtwW00qqVZVtAsLGipwXBvd+v
X-Received: by 2002:a37:a7c6:: with SMTP id q189mr18281725qke.469.1572915293238;
        Mon, 04 Nov 2019 16:54:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyrX9VI+c8WOT6M7oWIp4pyDtJDt5bkVm4lsJ+Pto7z9dB2TfD2fE/LTt42veVX3e6Xy+Pgiw==
X-Received: by 2002:a37:a7c6:: with SMTP id q189mr18281700qke.469.1572915292941;
        Mon, 04 Nov 2019 16:54:52 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id q17sm14389538qtq.58.2019.11.04.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 16:54:51 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
In-Reply-To: <20191105003306.GA22791@infradead.org>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu> <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
 <20191105003306.GA22791@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572915290_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 19:54:50 -0500
Message-ID: <183873.1572915290@turing-police>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--==_Exmh_1572915290_14215P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Nov 2019 16:33:06 -0800, Christoph Hellwig said:
> On Sun, Nov 03, 2019 at 08:45:06PM -0500, Valdis Kletnieks wrote:
> > There's currently 6 filesystems that have the same #define. Move it
> > into errno.h so it's defined in just one place.
>
> And 4 out of 6 also define EFSBADCRC, so please lift that as well.

Will do so in a separate patch shortly.


--==_Exmh_1572915290_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcDIWQdmEQWDXROgAQLCeRAAuaK/m71WLPW3IHgW8r5L9+3+x+9uaM3q
1xF50a4RrgesQOcgCjLxlCHEj7RzckAn1cAh8KCEfckr5crfRHSqOkSop9jE5A4X
BG71oLoyeYpSB1euVq/wxyUk7pk23uB3YfoPY3GD/zNUUxinrXRcc5AIBake1wfX
1tuIjSwBgO6HILMF7PKK+ETFDGBDXKUfzep/1ooWpKYzqbMyLkrd5iYQy5a9Fy3r
wbIOv0vg1dyMa3rcpFO6XKieD3yZkPO42lYIu6Te1wFnykmkCpgkMaOGP9/HWIPP
vkm2vDMS7gbWWYgbs2k0IsKKKTjhO+sapW3QbYNnxYEBgwYaIfaKhJGpqWQ6qoqR
Lr2OQWp/xv+g6bKr23kdXM+Iz8i6m38gl0LPwCa0K5I1WHSbelWoRniJ41jRcVeW
GPr6Hu+CZxD0nYigQV7AXFnlk2E8X525kiTffPz+KtMpUS8VzaSCMkc7GQMMdPbI
bZD328DLengZVicm271CUIiVhHvRD8tzw/6Z3UyM9lxCCjtkpFQI+ERMPATGTT/D
hwZmJzEj5esJYzs+PyEDt/d7pA0kzpW0XObEjX7apDgMWXWk7WmczJPPJENH6lVw
ULNeg4s+MlG6qt3eiC8+DPM6MxQtyen9NaE90UtCHunhRxt6tZSzbGSuHRYVWCdQ
9OgZEz7s3DI=
=W6JA
-----END PGP SIGNATURE-----

--==_Exmh_1572915290_14215P--
