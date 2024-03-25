Return-Path: <linux-ext4+bounces-1743-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E06889BFE
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B3E29369F
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD6614F132;
	Mon, 25 Mar 2024 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b="IQE+vdCu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762E2FE849
	for <linux-ext4@vger.kernel.org>; Mon, 25 Mar 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328673; cv=none; b=hzLp5ZRyjf323KkdwL98KnLod2LrKNp5PKWh94DVFReIiHJeYBmb7hvUp2p/gX6nkWvLATtNn4rrdVRMcYqC03eTbzH1+E8V7kEiSYX+J438Fhj1dXfgpGZsQGOkFb4IAi16J34KXiBQ5jGZJ5ruCj2a3+y5gAoS2YOiXSojjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328673; c=relaxed/simple;
	bh=HLX58pQI8SXB83k8TSE9weXRimPojqSZLVQ1p1YQbgI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id; b=cFXOxluI5hDEc00IgapaYXSgCkNdMEQ/Ztgr9Tmh8hZNMl185mUVA0wM5jRMyDRQ1p9XJPj5rmo33Q08YOJ6G3bpgdzLGOAEXc6UOJzbMvCnfhDfyVXgrciaeWvOYsh7x03oAb9p720DRknI1qEaxdY+tkeSYpdVQ2/T72d8EGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org; spf=pass smtp.mailfrom=mforney.org; dkim=pass (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b=IQE+vdCu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mforney.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def89f0cfdso35350855ad.0
        for <linux-ext4@vger.kernel.org>; Sun, 24 Mar 2024 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney.org; s=google; t=1711328669; x=1711933469; darn=vger.kernel.org;
        h=user-agent:message-id:in-reply-to:references:from:subject:cc:to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHYqBGYlnixcvfc0J1Ave38pS8nETGdngwvpSQTuLI=;
        b=IQE+vdCuZCtEiCY60KpIUO9OQh9G++Wknz78+cyc7Ud2o2qUHznuxRpaLwpAGdJ4rd
         oPDPBZoJdNpoTvUheeUP8nTca9is8fwXXZM96QtWKcTHlwPaukC/wB49eWmtp4YihwBu
         BFgbcITIZ7zzyINgKYG+bwCKuR9xk0ZwJJzgPU8nugxfik2th0xX+4whX7SnZHPcZqxn
         63i9agWvooVS+knqlPzdae5Rjs0OmX46FunjOX/z2aH66+ZFBVGgkVYkhTQZcQOm/0Ma
         J0ASj+MhyjhcFNjoDMOo75f1lw727O7Zwh1a7oAY5ekfmBzb2IuyIRS4ZHAIiQ6Sznkr
         En5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711328669; x=1711933469;
        h=user-agent:message-id:in-reply-to:references:from:subject:cc:to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHYqBGYlnixcvfc0J1Ave38pS8nETGdngwvpSQTuLI=;
        b=CgirPNuwQwn8txiUQrqzhGPCNIK+LjyeSzOz7Z9GspeDpWiyolm0PdUz6u5vj2yyqp
         6B1uF4e494XEkp44EIrHZHJikXdXP4kn5vqpU60QGl1C7OYXt38cguVpxqiPzVDWRpUp
         OThqFeMirpKqmy3z4jqvb57jhTijmda0U577mkkWsUMBg6/lKz2ZlFHBH+Ku7fgqaMte
         grEjdyHH5qhsmI5wPoMXEnhiidndkOdfIho4CcwuwFfjtkDdN9mHUhBbJA/uBCwLzunW
         fipyq1kF90/FqbO5nKkkvG/wtniVL/FOR1pLkTFW81EhR9b+I1bksIoGmxPakFPQRnY1
         hlBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqXbRvvz6HdJvtpdmJG8LduqF2/2sVfZIvpaFBKkAtD47XHucthpG7AoEZc1HaHK/kGNp/AGKJkqGdplY2/r5Dy0h6lRh+uN128A==
X-Gm-Message-State: AOJu0YxGcbRsFuRTQ8G3FUVXr4bUagXqVLbfnCuk4svWn2PhpljhH9tj
	1+rVCBVYktP+V0IwcNjIilIuAnKBnaAazV4XCT7KE8b1kfbLnjyYe9pzI3J+BL8=
X-Google-Smtp-Source: AGHT+IF9rqoIR3PNB/TlJ2XWMaPhpL62UD/3LEoox0CR8/qaVG2+VF6WD+iVHRPIggHdqTBzkOszmg==
X-Received: by 2002:a17:902:ea08:b0:1dd:dcd3:662c with SMTP id s8-20020a170902ea0800b001dddcd3662cmr8076630plg.4.1711328668680;
        Sun, 24 Mar 2024 18:04:28 -0700 (PDT)
Received: from localhost ([2601:647:6400:20b0:cab2:9bff:fe88:d09c])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902740900b001dd3bee3cd6sm3618763pll.219.2024.03.24.18.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2024 18:04:28 -0700 (PDT)
Date: Sun, 24 Mar 2024 17:22:50 -0700
To: Max Kellermann <max.kellermann@ionos.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
From: Michael Forney <mforney@mforney.org>
References: <20240315142956.2420360-1-max.kellermann@ionos.com>
In-Reply-To: <20240315142956.2420360-1-max.kellermann@ionos.com>
Message-Id: <3MDOTS1CN0V39.3MG49L9WIC8VM@mforney.org>
User-Agent: mblaze/1.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Max Kellermann <max.kellermann@ionos.com> wrote:
> This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
> commit caused a regression because now the umask was applied to
> symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
> has been fixed somewhere else already.

Thanks, Max! I've verified that this fixes symlink modes for me,
as well as the flatpak corruption error I was getting.

> Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Tested-by: Michael Forney <mforney@mforney.org>

