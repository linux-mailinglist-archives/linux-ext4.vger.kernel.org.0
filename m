Return-Path: <linux-ext4+bounces-9906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654D1B5237D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55702465612
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F4F31194A;
	Wed, 10 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRhw/qQU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F91311587
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539929; cv=none; b=K4nkeW3Ey7UfBLg2pFYGUgu+GjdV/L8D7ouA7aeeLQsz77nPpqJmroOku9ZVZpTnUq6Ae1pXrwyLmXgElhHUFLQlbZ4Xf6zCGH6US2dNVenzSinDbm4rkhKGL5hB84LpL0ze2t3m9lLtR3XNBNcF4KwKOh8Wdbh3Zs6GcJ1Hp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539929; c=relaxed/simple;
	bh=eYQlClmwCEhaI0edOagJ3xtje2vRur3r5836CITj44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9mxihKgJ+vCPV2q5t7orB1JyiAnV01OT3xNVDwFrn1QsJKoK2ngSaEwXuwnZSdqwJlTsXpz1MqREJpUxVvtc5ZzZosTRD7Ujo2Lz+ktFtz7ELXBmd+dZNMODhxhaj2yqAVrhOqbVPnz+PR8cxGHBsRDIhc4DTeWM0WEBRFo0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRhw/qQU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24cb39fbd90so63505ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757539928; x=1758144728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYQlClmwCEhaI0edOagJ3xtje2vRur3r5836CITj44Y=;
        b=GRhw/qQUg2QipWDwyEwDwZcznYv398kMFlXxGQvr3WVpzaMfQk0vCxm8s+ilWV2x32
         p3DsqL9sduYhB4Kniuq3jsQTK4GpJZHefsnede/mWWteQPAtG+lU795SdBNvTgwj+DT0
         +kceP2+hJH/XO7BmJoGFwI1QGEq9DpFX9FNg57bX49V9ekPNcbg6Xqotf7dOIfm72fXr
         xuH214KMBl1IzfyLZjnSHDVQfwRyPa01R+vEOpDcJQoo0uumoBAUdqiEUo9dgILY5m9O
         S7+ezgbiDF02kzd/mnjumfi9bbpVg2Q0Y4uF8FvHzlQp/ZQHFvIWeF51Fe3RqznCnKiy
         MqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757539928; x=1758144728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYQlClmwCEhaI0edOagJ3xtje2vRur3r5836CITj44Y=;
        b=ei1monyonBrCZmCX8gUllSLgCM9td2c8paR5VIPUQ6wZw/HbCYBFPQVWpv4eKFN5wC
         dArZ3oHexGh7bbtK5b/TUCmsA6BWKK0rt/61WbINs29wN+X5F98IyVCU/0N+/P34I9EN
         TV2vlu8glheiUf3JT00TAeCU8ZMCL761UoMmAB+DEFls0KRp9d09Wr5UvNzEdUB7Vpfw
         mHRWSIhnctaM2h18ZVq6U6SVLLZ5tsb/ZyOZmwONPLjlSNB7tHjPiRqRYihYNmZBrn1U
         kjDIH0pBL6iPMAexBiL6/2msRQXjE7I9oIgHd1Cr7IBUry8NgwAYKm1dSGgOkRIYov6/
         fxRg==
X-Forwarded-Encrypted: i=1; AJvYcCVw8KZQF5R87WEf4t7jAqQLcveTld5N+ULmKPSEP31rfiBwJx79W6Qelk5m6XQScofoqBuUbxNl356Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwFypid+4obDhZI7CiJ8Ng9Zo6Ul2d2fMbXWotcDQzeExWODa1D
	GfIdL9iLyCjVUQ2JJKqTGgcAybubGr+ZzaTJ8UXl9WKSz/grj9ZpD77K7D5TnkyA/zFZkQsFUkI
	3lEBLw5zFyfCNhgTVC52d18m6pOgyNIrVy77+HSfK+g==
X-Gm-Gg: ASbGnctB7uPOLzE/9tFJR3d4AUIAqTeG+zaGs2VTMZjKUooONuX6Ag69mccwEsnkVbD
	45aCm6fi5woTYJpttjC+UXB7COjBwXAaLdZCAn2zv1T7GBhtW9hqwVEQdrYjiHhS9IPghP5wA4r
	p8XZGyXc4vfoDFExP6n2d4jKu/W38X1wN6teMdS73V7WD1tQj17RhWM3DsFzRBQvngsKj2aTDwC
	ECLo7tj02ALEeEB/A==
X-Google-Smtp-Source: AGHT+IH8xKgR96C5XvuqLqmkj882R4afsh5T6C5ymKeizw+1jStwyIw/ZreAXzOZ2RxNpA5JqnebhOqUgboex8OfedQ=
X-Received: by 2002:a17:902:dace:b0:24b:11c8:2cfd with SMTP id
 d9443c01a7336-2516ce601bbmr265667605ad.7.1757539926808; Wed, 10 Sep 2025
 14:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
 <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca> <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>
 <20250910145241.GA3662537@mit.edu> <CANp-EDZ-5_UC+p77d+ZPMMtbH3eXAPvoL4tR_EL3dcpBk-wKeQ@mail.gmail.com>
 <20250910204543.GA3659556@mit.edu>
In-Reply-To: <20250910204543.GA3659556@mit.edu>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 10 Sep 2025 17:31:59 -0400
X-Gm-Features: AS18NWBvQhfhY-xjbWhLFCuyNRJIDznbX1xDj3gFWKweMdOtF_KMVfCMo7Ki1SE
Message-ID: <CANp-EDagbnACsxtY5MT0yJk3tEuV=R2kapvKVNvua5azD3UyzQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:45=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:

> So in PRS, we need to save each of the -E arguments --- or concatenate
> them together into a single set of extended options, and keep the call
> site for parse_extended_options() them where it currently is located

That what I am doing in patch v2:
https://lore.kernel.org/linux-ext4/20250910-mke2fs-small-fixes-v2-2-55c9842=
494e0@linaro.org/T/#u
It makes use of the already existing push_string() helper, to make
copies of each argument.

-Ralph

