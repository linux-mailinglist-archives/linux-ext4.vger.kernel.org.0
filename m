Return-Path: <linux-ext4+bounces-9890-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DC6B509E8
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 02:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4DB1C61ED9
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0A2AD1F;
	Wed, 10 Sep 2025 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="YIH/tylT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9FEEC3
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464345; cv=none; b=o3YmLsAbaVXyUjHniRBQIUUxAndgZPNbwGAuWIBWtCVPso+sfx9SYnUgouU+a2F3KixgNAVL4yCMJ3kkzDIrJQ1zgRtuScktG1MqBzwKwLJduVTADubuSgm7fsfLIvPcFk78fAwm9A+svVpCRMjBSbfvIIJjAILis1cpZOm7CM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464345; c=relaxed/simple;
	bh=HJo1te7Ku+PxxAznMzaQrU/bYd7xlAyygXIEzh5mnt0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=MYYKNQPUN8AMBaaJrlyc8HpYWBzp88F5ajFdKYU3knob1WXsHmIuATFwlvynHRIiXLR2hBds7/3x7eMNJDAlxyCw1Zy/FUw6QvrrbgDAgny1HveDRQXssJxeU8YsXchkontgB2tombQfEJbP248ns9/+76zH94Lm/PSEWbNRjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=YIH/tylT; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47173749dbso4301389a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1757464341; x=1758069141; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eo6ruNe+Wke/JT8bS86UKt+83JygO6RWXeSgCMG+txo=;
        b=YIH/tylTHWamvovN5Xue7TQT5xvHckfFHZkZN9cj0zLS3uYhOavj6e8wONk3T+E+G+
         7NM+Ffxd3zxh/1FA2E1LcDx3QUK9H7824A7amyuAiI1sA6Tf0Lkdb2Y4Bz7n4K0KdGDL
         ufm+e8eBFqDQxg9ZnDTm1mEkcvdhf27ziucNg7o7RkyRei1wH3n6YASdQLinxr1b72JS
         qpfyZAQ/eSyH5F9AdQ3/9tvslSs1VXRmSsB6ReUKslEqGvXbT1dVd8h1Tzi43yZcety+
         zPUAAABzyOwDXEOiWFOuDDprgI0DnZNSwz2Qxg6KWM/rGPgCUUwc/OOxnPRtmamomQRr
         T93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757464341; x=1758069141;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo6ruNe+Wke/JT8bS86UKt+83JygO6RWXeSgCMG+txo=;
        b=ioHvyW/XxZGzATMK79SCGhxiwtjXUPo5Ch/4FrJW7KLk6ohm1zAnwjju2Gtk6088aR
         klIz5zOs1phrSdID97PzasTGAiTJuXSXnLWIe5loTpBDBSCWfETEdqLbohZzYvxE2aCS
         9vT7/uah12ef1MNp9hg4An2r69RjCzi+egQMFyP7IJPDRnr1YZdGg8epy0TCSM2OQ9J+
         9I5siF+hacTP5LcxogfNZquQpQnwpsz3vTDFe1C901DS/kfjuCgrMHQktsSAnd4fFMgi
         5uUprUKFfKGrymDZ+oesQ5pdumGthYAq9M3pvlwGL1G74nIIt7CUitgYDKcjZBrY7HL9
         ranQ==
X-Gm-Message-State: AOJu0YxvLI4G2WypJnlnH1gjDV94TE3uBdySoThZe30+C4ZVRzjYuduT
	Kr8w/YMegKGldZ4ihtSnzwWtpCU85FaW6X7vstxWdzDKdV1qVIO0soDzeVtyIqixL74VA2Sj2kC
	FSq+c
X-Gm-Gg: ASbGncvPgPz8Jm5Ceq37S1aXCRSWsxoppyQSfJ1svk2552dkfDl3uJlNfAEKqnS/6PB
	xJNSuVCyF4VyNEiLi+xJvDsb0RX8t+iZdYYE7uJzsDLmGoLawP6l2mDdtZthGhPOW3x1vsTWFxt
	QJl/Xi8rigen7cjlFa4GnRTqxUXpB43qBLxTpCO4t4bMxGC0ok73ZQgPxqfH4d/foNiTwBRoRAO
	w9tkBuLedIa5aUElGGiSTaHR04XsuVADi3lsZtNVrCzio7YBG/xiME/Or3RsP/3ACJNKlhOCsx0
	p7WIt4RHMQP2zsxJl6drPJ6/apuewmTyksVm4WHitzLn75kb0WZJXlmOHOtmWaOpPx+1sz3oNvX
	ZNYlrNE4hZDV2BOTKhDZeBEPiaJ9zingX3hfeB6GctFfdG81eetqzH/QM8lCtLJ8YULfUGiTqIR
	ojjqpu4DE=
X-Google-Smtp-Source: AGHT+IH9sZHhk9WdIyiSTUwwkDCsFbva1PTyz6ZHiupkbGlXVTewgBiO1UNuS0c9aXTAn+ja27kV2g==
X-Received: by 2002:a17:902:d2c2:b0:24d:3ae4:1175 with SMTP id d9443c01a7336-2516c895b06mr219714105ad.5.1757464340605;
        Tue, 09 Sep 2025 17:32:20 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2aeee44esm8964405ad.134.2025.09.09.17.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 17:32:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andreas Dilger <adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
Date: Tue, 9 Sep 2025 18:32:08 -0600
Message-Id: <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca>
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
Cc: linux-ext4@vger.kernel.org, Ralph Siemsen <ralph.siemsen@linaro.org>
In-Reply-To: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: iPhone Mail (22G100)

Ralph,
I think it would be much better to allow and merge multiple "-E" options.

Cheers, Andreas

> On Sep 9, 2025, at 09:43, Ralph Siemsen <ralph.siemsen@linaro.org> wrote:
>=20
> =EF=BB=BFMake it an error to pass multiple -E options. As per the man page=
,
> multiple extended options must be specified as a comma-separated list,
> instead of multiple -E options.
>=20
> This helps avoid surprises, as the existing behaviour is to process
> only the last -E option, and to silently ignore any earlier ones.
>=20
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
> misc/mke2fs.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 3a8ff5b1..59c7be17 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -1796,6 +1796,12 @@ profile_error:
>                _("'-R' is deprecated, use '-E' instead"));
>            /* fallthrough */
>        case 'E':
> +            if (extended_opts) {
> +                com_err(program_name, 0, "%s",
> +                    _("Multiple '-E' options are not supported, "
> +                      "use one comma-separated value instead"));
> +                exit(1);
> +            }
>            extended_opts =3D optarg;
>            break;
>        case 'e':
>=20
> --
> 2.45.2.121.gc2b3f2b3cd
>=20
>=20

