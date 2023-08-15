Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A377C45A
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 02:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjHOAQo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 20:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjHOAQ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 20:16:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DE0E5B;
        Mon, 14 Aug 2023 17:16:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc7b25c699so30009115ad.1;
        Mon, 14 Aug 2023 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692058586; x=1692663386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weB9MtIJFBDelUwYLkDTbi/52FIM6MLhscWSCwc5acY=;
        b=FWpSGHZJ4CdZ12v0OGENLtiQt1uOLNFyMNnseZF25em+3ZLWH01DTz5JSVA8qI2O0G
         dELHOBFz2lbQexpXMcn2rMjJ7mx7fjXibSc2c/HFDloy+ESY9oECuDx1MUqT8riYWgBy
         eOiidbErXBg7TZhLbKY6dOquV1SFjhcN6Rj8tIWJI7fvTuKo7ydOoW19PDBAmNbvkdD+
         SRxNboAL8P0jH6aAT9r8imATRL31saGZ3Y9iTQmo+FbyXsYLi4tlCULOQidR8Ryw5ydJ
         Vr6jNWbEtEgOzEyObCm3+RabL5nQ9rn/JkMDVJk2nrissQDFdTyaU++WwZ1O5BUlb2tz
         /zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058586; x=1692663386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weB9MtIJFBDelUwYLkDTbi/52FIM6MLhscWSCwc5acY=;
        b=N80ngmcnTQJaphHcGYUZ4wzYaJH52qUdx97zyYbsxzTQk1GFh5ULyWAhfy3w4F+40x
         YYWevmcHgqX9JUtZUYVlaiaBODM8UJUxCe+sj2nwcU+qw08I6PmQ93cro9TvTux3s5ic
         fu8415TApyPkeRziyx2hln9Jf9+U836Q7VqOZ8A62DjRdgBSPU/WyjBqpvuB4m/uNocp
         LPcVvWoFvs+8e1f83aIT2khEVYE8rjUDiPNPlIPNMter9tXlzOD6vZzOaBGneu9/h1qO
         kbcOz+FEtW2dhLwoBIllTxAXNzJxtkNGtmI2dGwdE3MflsZTeJBCnFZYqoTZ8HHwaJdY
         7rdQ==
X-Gm-Message-State: AOJu0YxzoxADLo33tWbLPta2Qig4FgGaVIN1zLypolg7FlRPhmNouP3u
        Xj0yhQYWZLpyoFjcbJfdIkd+JfoBYgo=
X-Google-Smtp-Source: AGHT+IE4YWmOgaBYgfy3YZ1zDOqbgFEcdff5iiTj+lIjmxaDggUgNgT4Dag7PaXNNgOpekYuWvUZqw==
X-Received: by 2002:a17:902:e546:b0:1b8:2537:542c with SMTP id n6-20020a170902e54600b001b82537542cmr11481460plf.43.1692058586135;
        Mon, 14 Aug 2023 17:16:26 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709028c8c00b001b9d88a4d1asm9999485plo.289.2023.08.14.17.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:16:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3215681A2F01; Tue, 15 Aug 2023 07:16:20 +0700 (WIB)
Date:   Tue, 15 Aug 2023 07:16:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Dr. David Alan Gilbert" <dave@treblig.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNrD1BBvDVh-npz4@debian.me>
References: <ZNqWfQPTScJDkmpX@gallifrey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pd4/NvBj/UOcpGoK"
Content-Disposition: inline
In-Reply-To: <ZNqWfQPTScJDkmpX@gallifrey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--pd4/NvBj/UOcpGoK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 09:02:53PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   I'm seeing a few hangs on a fs after upgrading to fedora 39's bleeding
> edge; which is running kernel 6.5.0-0.rc5.20230808git14f9643dc90a.37.fc39=
=2Ex86_64
> It was always solid prior to that.  It seems to trigger on heavy IO
> on this fs.

What kernel version prior to this upgrade?

Also, it'd been great if you can also bisect this regression using kernel
tree obtained with git. See Documentation/admin-guide/bug-bisect.rst in
the kernel tree for how to perform bisection.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--pd4/NvBj/UOcpGoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNrDzwAKCRD2uYlJVVFO
o2A/AP0dbAmiqwyQXR2Sig5gkTpPzts7Xdtdfnh7sACSTfpTqQD/Rd4KpsiGkh/6
TbWXJdSgmaEes7R5LKdgliR0Rw109gk=
=S/Tg
-----END PGP SIGNATURE-----

--pd4/NvBj/UOcpGoK--
