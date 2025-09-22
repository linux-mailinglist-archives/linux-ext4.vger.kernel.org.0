Return-Path: <linux-ext4+bounces-10342-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F74B91BC3
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8278163B05
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B11DF970;
	Mon, 22 Sep 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0pA4+h8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FE63CF
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551515; cv=none; b=USpCXzw304585KShsWL9IsGBTo26liq+P4a462UFuxVDesNgMzkMzIjN82bJl0WgxMkcr3EQ0sM00y9yURdDV7jL9RbpSl0un1Cy2RoqUK3JDKV3HZAE6QbWvW20p+e+/1IwVHAqvRg1pBZwMrcTcwqwPkM0ny+iiLzsF4xCcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551515; c=relaxed/simple;
	bh=ouSobBrvrPEjIntU6IiUgQkiIFdyqUByXjVAWQkkYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge6ZeFWALGdzuw4Z4GnW53O0dqq/6PjD810EgWhij6ajOwChO3y1MPM5Wkq1d8GwvrRb2PKVadhbd6SHSmQv0DbEIUd2W4Mn+YEmq4sjr3Bkd3/NcP5uVcAMza02UL+4zW+J8H2QlKdz0pLcqCkOSuJQ3+W9p0pSlK89v44M+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0pA4+h8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so3315789a12.2
        for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758551513; x=1759156313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZOMl0rbB4rK/cYMevQSqJlDe4bsEC9Xzmj/JVEP82U=;
        b=u0pA4+h8J0/VZdefwGe/1fVwRRPAJ9nXM9Up7zxGOxKbOUk2yOJbVw07QhC2vTW677
         i4akHkfDLjxiKDgtAtyRd4X+5b1JT0JWlulzCKMeTSzBCxb1jyrF0L0Gar9DengTWujz
         z0feDIiYFUvcljqdT1fMHpoTD3S88bOIMdBJFg2R8ZYvaMKpz+/+4loDDfTamNuYDO4Z
         Hp4TigUyZ555T7neJY08rAhvjfwD9ztNyjQwt+hkLt/rdbyUZRaHu53l1bc4hnTvwNWW
         hxr/3c/oBu2tha6MTfhTVHv5n3I5q1wuTlyvGUq3Tpl1dDPOML+zWxz8uVqjZ6RIHEiH
         /Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551513; x=1759156313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZOMl0rbB4rK/cYMevQSqJlDe4bsEC9Xzmj/JVEP82U=;
        b=rg+/IXCF+m7bC/5mrj60lNe5vgj1o3Ku3tLf1sWW2g6Rjk4DF0z16HW0FjDWtDwvq5
         xSt9SXcDMMfpzmlixvOWQncN6sCenWd/x4+fjnKh9EWQJx/CwLff5CiUOAsy385xWQMz
         STdo75H37CZmIGjFkpIQiYR15w0miyjmz8OsuFrmhrqOgHeyg6O54MPH1OUWfJnr1Ogj
         8BQ1itvEfVy2EkbG1Amee4F9LNxzKHxNESHDgsIolc3ZIyoK+gQzNw18R1Cc2BNQlUzq
         /Dq6lajI7QV1ogD3IthmQznLixg9CuzMl4Bnt3+1yqYJn6OoVtgHh7AgSP7mUP8Qc98g
         fnAg==
X-Gm-Message-State: AOJu0YwvVv3ozxUgzAfTJ7V3bRA+zLDD5SHpu49H33AuOILAZkvrca50
	jq1IAMtqWIyE64qsBYC9ppBKyf4oUyPVXMuzqNoasJHLzEW/jzHk27F1WmiEnbmoYwXbioNaWcR
	ExXINTS+XEWhivuo7jyM/c1GpivqJyIDVKNZTafRzd0dh4L7dzmkKgW8=
X-Gm-Gg: ASbGnct0o8CaiLenWv1qELBRROLFIarpNIzGzl5FA82WjR9HD5nUa+BWZ9nQ0qBocs/
	+4ebe7jtSayuaI5UiH6EzjxNS3dgP7lKngNpoRY6I/mi8NFRIH/A/IWJ2G8+VypQbhcjN8oGy99
	7/ALWcOoCy9DREii0mtLUwO5UrtHKIGQU5iO87G5XEL1mZRABW3y2HEnXIY9XrOhJBxnFKqBCqP
	V5k4g==
X-Google-Smtp-Source: AGHT+IGqyjAKfQIK2u0j7M6k/qoTUtNKHC3fdg6aJk28hTKHk4xzTf5UOBJq25SHmJIY1CauDWYW1NQyHojv5ZfYJgk=
X-Received: by 2002:a17:903:124e:b0:25e:78db:4a0d with SMTP id
 d9443c01a7336-269ba516b21mr180182105ad.36.1758551512883; Mon, 22 Sep 2025
 07:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
 <20250910-mke2fs-small-fixes-v2-3-55c9842494e0@linaro.org> <881BF477-8E3C-4CAD-975A-6656D99BAC03@dilger.ca>
In-Reply-To: <881BF477-8E3C-4CAD-975A-6656D99BAC03@dilger.ca>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Mon, 22 Sep 2025 10:31:41 -0400
X-Gm-Features: AS18NWART9fkX1IaylCj_38tIPwimX1ePkOe4AhNvDUbQ_sfwKIQZp2m02DNSkk
Message-ID: <CANp-EDa+aN+fs+gSPnSTzLGZNOUSkHBvzDV4OFNBBn02KT3jJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mke2fs: add root_selinux option for root inode label
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Sat, Sep 20, 2025 at 6:39=E2=80=AFPM Andreas Dilger <adilger@dilger.ca> =
wrote:
>
> Looks fine.  It took a bit to figure out what the ".nh" macro was doing
> (I kept finding ".NH" =3D Numbered Header), but I found "no-hyphenate"
> tha acually makes sense.

Many thanks for reviewing. Indeed ".nh" is to prevent hyphenation. It
comes from the "mm" macro package [1] and is considered part of the
"safe subset" that can be used in man pages [2].

[1] http://mam.sdf.org/guides/troff/mm-all.pdf  (page 35)
[2] https://linux.die.net/man/7/man

Regards,
-Ralph

