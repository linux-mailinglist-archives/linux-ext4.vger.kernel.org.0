Return-Path: <linux-ext4+bounces-9892-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E3B509FD
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 02:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C4F1882B04
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643C1C3306;
	Wed, 10 Sep 2025 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePVcg0t7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185091B4223
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465385; cv=none; b=IlshHlRBHcn/rc8S9iVOZdqcHi+HWL8RojbJfCqx2LfEyMiVSHo6yG2yoyuSKIN6DyPJOtgwSQs+wBe/AdMHnDA5PAP8bcWyLG3/zWjpkaCPkhAS7rA3A3/Wuc+0kL66YaRYxWDPsGIRUL6tvhB+MWxfJJIJe2vEgN6uBriKbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465385; c=relaxed/simple;
	bh=TKE4HdOvC1ejKn5HneVnmTZVFFAe0UxjKE4oZgynS80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/KWexjst6zKaFiqpMH+Ay7E03iT79LHhoKFE23Lyy9hTYEgGkSIJsz3izlDUzn3rEC0xDwPP6ypKpmXnTIcUurPiu0AYa5wubeE/SiCL7B//mvzqvYUDCHF0ie/9M/qtDdd7FfqiqtG6kPuvjACCYY+qXJ0wcK6gHSJlgJdWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePVcg0t7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b164146baso40442005ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757465383; x=1758070183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKE4HdOvC1ejKn5HneVnmTZVFFAe0UxjKE4oZgynS80=;
        b=ePVcg0t7+hqxJ9rU9ydO986hB3ehpRc2QUbA+9OLw6lzam64m143iGpGZH59yRb7PX
         7C2JHAZqyzYQHpPVSAQ577u4kJcEttYOKtWC5PRLZ9eE0kY7lFhA9ZT9zHvjSNfSKjiC
         UmK8iYfV1ZwGBmMcFLaBz9eO6R8B9cXwKqblcZyqVZNt+qltS+tSADneJHuMz6DkNApY
         sdvDJG0saTUg83MsFHk2/kcWR+0DgbTlvoQNgelUA5JZFgaU6AXByCs67muz87fSnM+Q
         4ORZZWAeReINzM2xvZr3XtdXcSLWysBI6zOWYMjKa82HxpjW0X9zZIkJmggYrN1vGbK1
         MBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757465383; x=1758070183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKE4HdOvC1ejKn5HneVnmTZVFFAe0UxjKE4oZgynS80=;
        b=pyjgid7B+PfyierDr8Os/U4JvimBAl4FtsSPsEU9hUtpdoHdYiixuGIg64zhtpvHLe
         VXK6zs6AvLXWK7YYiGD0Jvsdsp7wk8TQ3b0gRA6uoidhSqcKAchezLfeoG2fQ6bvXN+X
         ttGLZ3JNsPi8uSSLEXSuyxdygrpfifQjByEdQ4u6wzWWgPHw+CArtt4XEr2fl9W8BND7
         GK7ABFc2DP5MjvDNddqfZwLZ/22pYvamLe+aSjK1xVUxnRFK2SGajnlO3TgohEsesJwP
         lFFL2GEKiibQI6XH/C34r7118h6/f50TgKYORDm6Et+jDWAECoEvV3YkPMr/HIwDB/+e
         VcrQ==
X-Gm-Message-State: AOJu0YwjkAxMyldJXdpfj+jLoq5HLbmlQKG4LIzSJ35wQECurNjoPTKO
	kQScPG4H5EUdh5QtyZuOlBJ5nA/EfokOg3S8bPszdxFKRbDmZK4J9xdDTlFZ9ns9kPXevR0aO/a
	CcDrosQZ++QPzDWF35MmC4tlBviSQFn8XoBUPDNOipmRYFgK0ekVu
X-Gm-Gg: ASbGncu/rddhROg5SSFl0Cx+Kjc+lrjzdCkULkdSwF5Ocj6G9Ofhe2toRogA5x1TR9f
	R/Geeh7qwuGE4fu8WWodhOoRAEDh7o/sS+uXVtWih0MIXqeJeQLd+xPhedvTrMnZKpeYp9JigWF
	96uxqZMtooVzFtlsTCG9WTRhKbfR2JWuT7CcVVQPPN73nZn8sYm2Uxj3Ms3l+cyj/Um8HVtWqv/
	oeQ3qiiXcFnJue9/w==
X-Google-Smtp-Source: AGHT+IENkxqyJtviiH+TY0oajgkgkvS1TS1VimuSF+Jo6jZ/g/bhNfKVJQB8ECAaNoK7RDDZRwYn0tuuGiilfSBqqj8=
X-Received: by 2002:a17:902:ecc7:b0:24c:a269:b6e5 with SMTP id
 d9443c01a7336-2516e88526emr156267535ad.14.1757465383311; Tue, 09 Sep 2025
 17:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org> <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca>
In-Reply-To: <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 9 Sep 2025 20:49:37 -0400
X-Gm-Features: AS18NWDNMH2JizVnibtJx7AV7egx3cCinTNZtGf7MCOr65cx_xBTVBUb9ewTc7A
Message-ID: <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Tue, Sep 9, 2025 at 8:32=E2=80=AFPM Andreas Dilger <adilger@dilger.ca> w=
rote:
>
> I think it would be much better to allow and merge multiple "-E" options.

Agreed. I'll work on it and post a v2 patch.

Thanks for your feedback,
Ralph

