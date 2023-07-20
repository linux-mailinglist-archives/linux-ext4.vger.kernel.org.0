Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6783C75BA9B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGTW35 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 18:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGTW34 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 18:29:56 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290B10D2
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:29:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9c9089d01so992795a34.3
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1689892195; x=1690496995;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVWGh+q/8VtkqLDUkZxQPuszEyng1IUVcXlk96R75XM=;
        b=UupfPjnpdfK9XYnsg06uS2R5UCg0zMT/YxwUvUfciWcZI15RdCb7bGDiqBVEv8d3K6
         JnTFt7rIVGdjT4qZqp2heQxAppwqa3cRk4TrI16EeoSG0DFdO48MVU2Cloxg+KjAK65l
         Ulb+DTQfIHR4B5CZ9RMnlCiKIfKzNYfKh7/y9B8a3AZ9BUDAkzrmsz5yBnRLc6Tgajeu
         OyDKlld1RqJjb3Ub9eyCtbDRjTKbORExseRHiJEmWlgRy0ebuY0Lenhqo8jUhYGIpAxD
         anhz2YB5JwDJ0TrfMIqLkph9hZH+B61ZoP+0ApzJYXbJUpNuFg0cNa2NK1YtWFAoWNMT
         c5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892195; x=1690496995;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVWGh+q/8VtkqLDUkZxQPuszEyng1IUVcXlk96R75XM=;
        b=b4HxrNVXSeZliynza7asW4oyxtiebfr0lk6SxTLxcsFzlALVZpwbu0PU29nQrIHZeF
         uMOO1sm6upQ6T5hVMcRNbx/Z0ZwRLbyWhUJb3bUGANU0834eB0oM5PioYUU6HLNGl0GH
         dmz3c12x9YA2utqABa6tufAkn96x4hw/FQ4GJJ6HpkwtYXmTnVZQvIWcdXwILqy5WIhj
         LGQcw4DxaihCvRcTq4DkiK9FLUM1JE6kS+/wTyCNkNrGOerdW92tpz1e6z/IWfnpusgL
         nZLB2xD7h2JaT07e6oYZQOE88XZuOOzz8RMq+wKelyFK51jrOWa3wEpdCjYekW5Gniih
         RVYA==
X-Gm-Message-State: ABy/qLZcvsQNTm7RcwU2c0Ao7JEn8fJq8yFNfGBkWNTUZVH7DWs88ASW
        uOdU4Shgih2m7LIUkGJNWv6Qdw==
X-Google-Smtp-Source: APBJJlEp6AZGVfaVSqAlTfwPlZCwy2syAXmOT6Fs+ONh8D+T4ZJz399u99WDEYTToDzDdjvk+g5zBA==
X-Received: by 2002:a05:6808:ab8:b0:396:4bbc:9a36 with SMTP id r24-20020a0568080ab800b003964bbc9a36mr192926oij.19.1689892195079;
        Thu, 20 Jul 2023 15:29:55 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b00262e604724dsm3068776pjb.50.2023.07.20.15.29.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 15:29:54 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <349BD09D-4ED3-4565-965A-C5D62494CACE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1C877E5D-208F-45C2-BBEF-2537A2A568CA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2image: correct group descriptors size in
 ext2fs_image_super_read()
Date:   Thu, 20 Jul 2023 16:31:23 -0600
In-Reply-To: <20230714005958.442487-1-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        emoly@whamcloud.com
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230714005958.442487-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1C877E5D-208F-45C2-BBEF-2537A2A568CA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 13, 2023, at 6:59 PM, Li Dongyang <dongyangli@ddn.com> wrote:
> 
> From: Emoly Liu <emoly@whamcloud.com>
> 
> In function ext2fs_image_super_read(), the size of block group
> descriptors should be (fs->blocksize * fs->desc_blocks), but not
> (fs->blocksize * fs->group_desc_count).
> 
> Signed-off-by: Emoly Liu <emoly@whamcloud.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_1C877E5D-208F-45C2-BBEF-2537A2A568CA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmS5tbwACgkQcqXauRfM
H+AKFw//fQOKEz0KtbiWwMjMB/yBC50N906DnWDFNt/+nWuHBhlzxR+denD0MFKh
7P154YcbH82b7wHF2fw7xhalUeGN9UZbsaVUbKTlHMhvefwNjkUUD7MNEv3mHFVr
myFVBCEkkocsrOXs4BvdSLQENYknP3NkkvwT0djEvwO51cCrWY30uP/G0x4kFMpq
/kE6Zq0iY1dM8YTSUNOYElp6CbbZTTj0o/0OW/XA7yo6Bq4W1IGZmLpKIvaiQbze
8+h5L1hmb3uVHkP00AnBUEVthdaHS6jtthzalWXhFGgpSbQhkbibdb/pQHG7OSKE
GceGTf1l93UtUpc+w6ZwAyH9v2tGDvw+AJHL0WnRdjrX2UNOKVrAAof2E0/VG+/x
qAPyIWH/lzx9YfMMdQsXxtE0wMNtM7vA6DHXbAPGGrod0UBfKQQu4tUKoABF5GWV
7aipchIeBs1GxkPJyhRV9X0hYGz3li4Rc89gyIw/LDjwSDK6KYqwkfRqHQWJd+hT
I/lKm11Ni039Hmis8UA66epP8re5sjh2x6n4HWy0XIHVfS1Xv6Z6aL+o0aMapAoq
m2zaRChpgBKY/BK8AA9fTzlp1xs5GPMceTKhzSReMZ+Fcc2d/Afjy5M4hMUQdr8B
vdavC1Du1JQkUKPj06xW3KXIQ3VHto+wIstsgzNXA7esPJoH95U=
=7Q06
-----END PGP SIGNATURE-----

--Apple-Mail=_1C877E5D-208F-45C2-BBEF-2537A2A568CA--
