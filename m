Return-Path: <linux-ext4+bounces-8936-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC6B018DE
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 11:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DC3ADBF5
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD527D781;
	Fri, 11 Jul 2025 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgvJFw9L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D882279DA0
	for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227792; cv=none; b=VySTfd3fb7ZyraLGzSsXEWRFVMlS+9e9nmJZjXpthlDbNJzWPeGBBj7HvdENe57seloRv5k7C8yV+tCeTnJ4SuEu6Hx0pGhusFyAeiILiAIchPUBzDPGAhcsfS90uykfMakh/GGJilnZ4gppPK5ZkSZl7+eifOVOuZfJDy5qOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227792; c=relaxed/simple;
	bh=eeFI278ZVHjNBGuPHbwuDsyojzVYNkui1IJnWZGU8yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjyUp6P5uu7kO6NcJMubsRL+e2E5OkKwQdf1/OcJOUaFVm1T+lHUa/IpfPplP7AhzZM7+xgv0mZsnWX9HJmJsicxGqh3ImL7JE7ZH/+GgibwS1n51qdkZgoIn+7Kx5kVpSBuL3l00sePCLIPTf/TRpzn5wpDflvuqo1VUrO0dUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgvJFw9L; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55502821bd2so2027906e87.2
        for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227789; x=1752832589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eeFI278ZVHjNBGuPHbwuDsyojzVYNkui1IJnWZGU8yg=;
        b=QgvJFw9LBnUI5DV7wvVIcapA2BcpecGWOXJ+odQavKEUef3RsdheqfmheISIs3Hhzw
         +LGS9cTYu/CZUNhfBh3YWItYJueJs75CjqdXob6oeHyrKZpIivZC3BSFyBJiNdM/wC4Y
         jTdyIv325OIEFK8sNAPuUjdSYm5I1jPApeYHU3MMI7ek7CFpVQJllaxeqPLfiKoOlqmh
         16A/IAWn1aKJNYgSen8P8PBr/cgFTAtX4ccoWOKUDp5VdDuOQ4wRa/Kw8hiwMIzPDG8W
         IC9Rn4cob1DAv5meDFMY2ee9tm9MfgR11VKruty9z/3PkfjIwPH22H5uoiSJBkY6W0cN
         lmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227789; x=1752832589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeFI278ZVHjNBGuPHbwuDsyojzVYNkui1IJnWZGU8yg=;
        b=EkBAQrPGBei/pLH8NbnWavpgA3ttExnwhS7Xz+91zYEEZ6QfzHVcRHkOo9BEJTBlVo
         KsWspwUvw65KpBdiSJN9d5usNiNCTQ1o8EOv6nKYruXIOWQwGYL1dRSI2UP/1o3vaU7Q
         3u+Hnnlec6p2rrl63UT3YBekZ0qvLXDLTCHQkGNvPIRvxaQOaTvVvoNWV7Q0GsNHxiQ6
         CZF9X1lg1+4DClmVSjtDrIhKeKgVHRocWVjRCKyVjKJY4BR5VtqvSCZYAFxvpwfOO3eP
         0y3IM7qvRWJHENXB2FkV1qxcVahEU5muMvaAap4/F/1lDpSGgmeemkOiSym+qIrt4PHH
         qgbg==
X-Forwarded-Encrypted: i=1; AJvYcCWxQQOxyilyW6qF9O/wxwxhKDtRmAeD/6YyhD+tSYRHS/EN30b3EoD3XUBAXPn4ImlTRSZ2NZs8HlOV@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6RFSwsIfCUnz/NQac0MSD/zJvuwXG3RjbHur1G9b4eBHGd+x
	0bEPdVv/GlVu24LTPrNag8JZE8fPHUssIpSGRuioc1U9qXfBZ6XNmuJV+7TVa+1wh1Si+3TT8xR
	WBzqVurGUuGfFngG/sbbCt/ToXShS1Xypz7uPQRgdpA==
X-Gm-Gg: ASbGncuLWVRhgAZ/E3iP+gqxqSQpi4s2RVvO618MtLopACPcevr33CD3wFxApuyE4vn
	sFaR4z7qxMAjIa4iL4pi323d1bOTfSLxtXj5Hl2znVOhO1JiblXsM8gJs25i0/2DgKE7UM5DCQT
	P7VEsfkOpU3+/M0HOTmSK+d0aAj+5GRUHiDtlHDXAIrs9vjO4b8yl8hVCt3XmJDyEiskDJNUjaI
	SQT
X-Google-Smtp-Source: AGHT+IE0Qo+oxfKTB5s02rIBYvoea4ReXWxMIqPLfjTHHjcEQbdkzaP40F8HWVFlS395501q7ySCkr56dffZYAIX3/g=
X-Received: by 2002:a05:6512:3f18:b0:553:297b:3d4e with SMTP id
 2adb3069b0e04-55a04633fd1mr768248e87.52.1752227789124; Fri, 11 Jul 2025
 02:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu>
In-Reply-To: <20250711052905.GC2026761@mit.edu>
From: Jiany Wu <wujianyue000@gmail.com>
Date: Fri, 11 Jul 2025 17:56:18 +0800
X-Gm-Features: Ac12FXxYLyd86EoHzWINTylCD1kku8lrW3PR0q8lr0_ub3RCMU70Al_MkaXhrVk
Message-ID: <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: yi.zhang@huawei.com, jack@suse.cz, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Ted,

Thanks indeed for the help, really appreciated!
BTW, is it proper to fallocate whole disk space to exhaust disk?
I see even fallocate full disk size, seems file size equal to avail
size still can be allocated.
i.e. When /tmp availability space is 26G, but fallocate requests 32G
(total disk space), we see it finally allocated a 26G file, but exit
code is 1.
Is it legal usage or will it trigger some unknown issue? I'm a newbie
on fallocate:)

Best regards,
Jianyue Wu

