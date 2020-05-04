Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDEA1C498C
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDW0m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 18:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDW0l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 18:26:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F270C061A0E
        for <linux-ext4@vger.kernel.org>; Mon,  4 May 2020 15:26:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fu13so107874pjb.5
        for <linux-ext4@vger.kernel.org>; Mon, 04 May 2020 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WKulo7rninI+B68JvHr0gzrsDgYA9RGb2X7+x9yE/rU=;
        b=LiuvtKSl5CYfBhIuChwc0c15zuqTuhHdMGPuHIVI1S5Ypig+7EBnI4q8YnjHNrhZgf
         VfaiBId4iGud05iFJLgijHtGmVtVxIYH9IAklyautAyRwFlg8yFFlZ25DcwvPk/uWBEt
         uOwJRLHRho7Lgh+Fi18wg610rjl0O4cYsssKKkk27oiGxmJETV/PcobXuNel88G5YMAL
         fUvTju9QwxGBNllj1GfH7ebbNepyu/idBV0VCsU3h7gFSTNESxu9OPeOL/VSXLMD2EOX
         eq12VEMqyRM89Og0Jf3jVIJbrGDG/GzxvUmGKzVZ+5NHj/fjZLp2gSws5sCICB9AO/Xg
         nFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WKulo7rninI+B68JvHr0gzrsDgYA9RGb2X7+x9yE/rU=;
        b=XCfHSjBsfYrYGoQZUGFWlvmNz7OZDy8ngmgnbcdLSrTfKe2lGDI3SJfzYQaZf2WgU3
         W3TxEMk/di/1ezJNi7oBQtPjJFBqs7l7DdQ1u1lTx+xciSe+CdZ1ApoIzjkqT5lRKxkI
         l6GjUTxYzr+5uYquYDxasAqXc90wJMvwK0txpcwIppaCsHNRF2Mnid3SGCHP+FdiHukO
         WcrAdwtS4DYRmPGrxER1pTLy2R93LhfJbXX8jz8mrxvXYz2xLEFzVaqI2lzsYAaP0KfN
         aOMo0hBg5zkaTKqCnYUhpxmksNkszvBfNrvZ/nXQWJ0Y+dm533X6q+KIovH720/glRT+
         0ATg==
X-Gm-Message-State: AGi0PuaRC/KumBy37vqKoRzRVEeAYKn0SM1hz8o4X6144VNHV973jVXU
        XT+w6yhhuvAF0dU7YGrs5/0AqwEDZUdmew==
X-Google-Smtp-Source: APiQypKSsewLMNxnOtccocgudGh5aQ957sP+pUm2b8MO5WapvubMzWRjqOK7Om+FLEVqDBNpkMlOnQ==
X-Received: by 2002:a17:90a:f689:: with SMTP id cl9mr119815pjb.43.1588631199444;
        Mon, 04 May 2020 15:26:39 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r26sm102263pfq.75.2020.05.04.15.26.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 15:26:38 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1B91A6E6-7F4A-4C58-93E7-394217C1631C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E724A58C-158A-4D69-B05B-293DF913E7A1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
Date:   Mon, 4 May 2020 16:26:35 -0600
In-Reply-To: <bf50e54f-2a0c-17a4-89c3-4afcc298daeb@jguk.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Jonny Grant <jg@jguk.org>
References: <bf50e54f-2a0c-17a4-89c3-4afcc298daeb@jguk.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E724A58C-158A-4D69-B05B-293DF913E7A1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On May 3, 2020, at 6:52 AM, Jonny Grant <jg@jguk.org> wrote:
> 
> Hello
> 
> Could a comment be added to clarify 'file_type' ?
> 
> struct ext4_dir_entry_2 {
>    __le32    inode;            /* Inode number */
>    __le16    rec_len;        /* Directory entry length */
>    __u8    name_len;        /* Name length */
>    __u8    file_type;
>    char    name[EXT4_NAME_LEN];    /* File name */
> };
> 
> 
> 
> This what I am proposing to add:
> 
>    __u8    file_type;        /* See directory file type macros below */

For this kind of structure field, it makes sense to reference the macro
names directly, like:

	__u8	file_type;	/* See EXT4_FT_* type macros below */

since "macros below" may be ambiguous as the header changes over time.


Even better (IMHO) is to use a named enum for this, like:

        enum ext4_file_type file_type:8; /* See EXT4_FT_ types below */

/*
 * Ext4 directory file types.  Only the low 3 bits are used.  The
 * other bits are reserved for now.
 */
enum ext4_file_type {
	EXT4_FT_UNKNOWN		= 0,
	EXT4_FT_REG_FILE	= 1,
	EXT4_FT_DIR		= 2,
	EXT4_FT_CHRDEV		= 3,
	EXT4_FT_BLKDEV		= 4,
	EXT4_FT_FIFO		= 5,
	EXT4_FT_SOCK		= 6,
	EXT4_FT_SYMLINK		= 7,
	EXT4_FT_MAX,
	EXT4_FT_DIR_CSUM	= 0xDE
};

so that the allowed values for this field are clear from the definition.
However, the use of a fixed-with bitfield (enum :8) is a GCC-ism and Ted
may be against that for portability reasons, since the kernel and
userspace headers should be as similar as possible.

Cheers, Andreas






--Apple-Mail=_E724A58C-158A-4D69-B05B-293DF913E7A1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6wlpwACgkQcqXauRfM
H+Am0g//eB0khVFFGvtTtnhMVmn7RP3/vJ3/EkXEviFi28HIkbopRr7txzXz6W4M
tlXQXL5vpdUKRbhapu1EbqqxHnkX29HGtvqgKy9jGC9brGI/zCow0su6wTLwNpt2
tvHdbV5VljAUTMzNBUqZ6bwoHvQjq3z0T4pE2lW3Sv4mdeGW6KDy2vgqs8GcLkHY
vG1xWQ5BRB+6T0He7iRKuB/3riPhkA7EfgCWAun3IL2emZQ0E8MnS61+MX5hQBc8
BYHZN+aUp44txBvvhOrdtQDUaf/CEuHpHUq6ysD67Bs6sx1wO6uRWra4bh6+1TVd
yhO9bc9qGlO3zxXFr7+OY87+YVJFpw09k66aae1Efrr4m8JGNoxC82Lcolpzmdui
MnJ8TmqK/jyki+2cDJVLBZ51YidUdjReTOFgRda9TdXz6RGVvU3RUVi6BJCO7uPu
HVI5d/C9UXukSEBp209ruX8n4wLXmmQtwVSrgV9t+to9yC74njeS85QfV+4eFTui
a2ddak90DLCerCZSD+99hqEGsegqLExS82FjxF09M0gre20SV2LyvbARjEAZRMXN
vxohGkjooiQRvpOxoK/P6bDi5yv8XT5PbPnw03Lx0JzrjqPAazVlGgGJWnfH5eap
2xfS8zLdOMQyVxzIRxV0x7m+5LJ2S6WrhzsAPTqohoJlfpVkDUM=
=LO98
-----END PGP SIGNATURE-----

--Apple-Mail=_E724A58C-158A-4D69-B05B-293DF913E7A1--
