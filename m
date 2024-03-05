Return-Path: <linux-ext4+bounces-1520-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4B9872582
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF265B219CA
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F36168DE;
	Tue,  5 Mar 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmvmU7oi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E017583;
	Tue,  5 Mar 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659012; cv=none; b=ZEkPZzVfJ/IXxM+fQpg3TOG3sGXhb0D5v06bZd4Mwqk+6u8Vi5A4MSQ5Qp0SXEiy0RkVMVpzJZ2y6gBQ7xIw7PGqDTk+QXYIW2F/Yjnt05ZAgPipACLyFyyFfGLKrqcwT+E1g39w15IfRQ/SgFdFnrL/vUJOsTZlShhrfXelv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659012; c=relaxed/simple;
	bh=Pe1mj1wbiAHxITTX6lSOwpMRXgsL0p/qN+SI6tCSYvA=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=hiOCJjqa7317WMG6emNsGQugFPzj4LjSKdWp0p1Ocd/h0tan+wGtJsURBDNs7xGUrkfDmkA5i2fAFwV+1GLxURddMcIrosbs9qQI1LWNq4f2Aq10lJoM2OM9eaYGP7bYXCNQSXc6Gl9sfAQd1u+wDVYKpedM8U4nNaZwwtFa/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmvmU7oi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so4608082a12.0;
        Tue, 05 Mar 2024 09:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709659009; x=1710263809; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mqClEImGAVR+13GNNVSvl83oypLG5Air8fAgJUs1O7A=;
        b=JmvmU7oiQhDUmHuTZLfjWGvKVVVtk95ExO55jyolEQWRWZyQmxQenpNWwdja/M2Qkr
         UjhiprMAVNXFdrpQR0swlXcFXDOMqtrkDGgBby9+cw3jex/AIedV5VNdfdQ91CRbVEFg
         LKabh6RQBSWZZYI1hjksb6p9gO1RDW9xYz/MzDXpIv0LitgLIBt1VHNhV93r8DJdeCx0
         9Eg0cKHyMNt8axB3p99n5XC5SzPLRYIH4JPpP2tAlMc4fYH3RX66p1udS+KzsWbiugUU
         Wi0FYXhzfs8cN+Vz2GNNSL/phWPB3LLuIWYeLtu56iMJeltpNG75eMKjvYAYNqG0Esuw
         eh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659009; x=1710263809;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqClEImGAVR+13GNNVSvl83oypLG5Air8fAgJUs1O7A=;
        b=U2sK4JGphsh692tIvcfKp2Ux2N9ptVuBpSyDen2MQAMm8C5S63fZtSXQsM29QnYU3X
         z17iVhsslNdD9tQVIaZsAb8PG20xympn6h9/jY8+SLAVn/cnMOeDcsa1gySyuKsM+LgO
         3uEosxFwIIs9zYjsPq4zXDhcXC8V49rdJ7mebNZw7XsN+9G/bn09lGHRIPv+Ke6edJ6/
         jSf5T/h9iHcHDg/r24IRRySJC0Lwz3OXsqVDIjYuG+mbQSnaksaUtxd7pKIh9sRsadjy
         vjiqvxtAnuHNuVMou0iDB5oIjG4QbvRwsfG0M72hViwuLUf9rGQmvipwZSUmSSfow5dF
         CDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0z/HMregEClH/oyp3zjaW9Fqul5OpsxkHjvthxrGr+A3FJHw6VGxy7M5lH8MaAhe2sSo00QwuhA3P6MzjoXDE7OSrZ2VfpSozsBAg
X-Gm-Message-State: AOJu0YyYj70P0NNfp4a1IRtIQ9zzbG/vUJqi/NfnpJiNf8un/7svY+Jl
	laP3RdP9C74KZYM9dXm8vKWRbpj0YmEkT11Zxi5nsyJv4Ma6TF3467gYNiKb
X-Google-Smtp-Source: AGHT+IH1kSZpwLX3zfvS6Xwbl4F5xCu1KzWtdKW2+cKMba+Ej84ubqK8d8trKshlOE0U7ade3M0p8w==
X-Received: by 2002:a17:90a:9b0b:b0:29a:2788:c9d1 with SMTP id f11-20020a17090a9b0b00b0029a2788c9d1mr10048469pjp.39.1709659009154;
        Tue, 05 Mar 2024 09:16:49 -0800 (PST)
Received: from dw-tp ([171.76.83.125])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b001dca6d1d574sm10773585ply.302.2024.03.05.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:16:48 -0800 (PST)
Date: Tue, 05 Mar 2024 22:46:43 +0530
Message-Id: <878r2w4n0k.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] ext4: Remove unneeded if checks before kfree
In-Reply-To: <20240304165507.156076-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Thorsten Blum <thorsten.blum@toblux.com> writes:

> kfree already checks if its argument is NULL. This fixes two
> Coccinelle/coccicheck warnings reported by ifnullfree.cocci.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  fs/ext4/super.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Sure. Thanks for your patch. 
Looks good to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

