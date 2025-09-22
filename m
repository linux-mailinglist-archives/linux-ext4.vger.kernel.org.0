Return-Path: <linux-ext4+bounces-10344-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6FB91CAD
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9B2163999
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11D262FD7;
	Mon, 22 Sep 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RshCXe/a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3101258EEF
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552531; cv=none; b=tqcpYEoOYUCB5knl3wIgezaYh2kSgGEXqR+VNIJ1DaoQ4vHKv3FhkpAuLOJvrV8ma9AoOi3T2HfYrtfYcDLjVUM6l/aO17mPub2f8rukDfQZ/7on6XhxFTAbJtYy3Az5zu/atO2BjqyOOJNYbhTYa6Asvfk0Yuy6nuunFeA+0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552531; c=relaxed/simple;
	bh=afNJoQC7cVqbznnAzdFd7y9GJ4sXhkOWeg4DYXbsR94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjvEkM15AOjrvDJlVSjlCrV9YKU84wgyZjHePED/IN33Vm0xLADK5LC2kqw9Sy3TNRDcuQBcSpMbXGIJCkKbvgjAEi2msG9KDgJOvxm9e7TTKt1adGeO+qFYScj3YSY3frsyEsdEGVHalUNBlvzKnT9fhB5cgaUxCD/gvbYc78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RshCXe/a; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4d10f772416so4442151cf.1
        for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758552529; x=1759157329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYt7hSG03xNp8nbS9gZunZckjEyoo0WjKVVYn4ZLq+w=;
        b=RshCXe/aNtp2VQJcpPZxTad7RV2Ne18H/Dko7ziXBtVd4hvCSCvMsUrCpS8p4eB25r
         5xcSjPy7N0QUZD4VjVaRATzv6IkZnjkuzEnX+3AqO29jiKZAODFcVrZy3wxo/6hDpqWA
         fz4zqbzZOPvD/Zdm0/TyQeE7zX/jRrQcqFaceG6LcBSLJYL6OzPAvTDju4qaczOA4kI3
         X7oC55tSRlV/M+wqz7RBIF7QpA/nI2gpg0XZnPucf3kg1xIMQk5QOQdCflH5LaTJ02OR
         M8U+tIsvNkCQvc7H82bP/11+FI0j+b3nZZXqah3lpv/Z+ybXIf5dTIP6f2wEJjR8cn7v
         Nyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552529; x=1759157329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYt7hSG03xNp8nbS9gZunZckjEyoo0WjKVVYn4ZLq+w=;
        b=mAi69B73Ipit0N8DrtmdCxIuD47JJXhtnCcLi6J0Lh5QjpnmMKwzN+Gw9tV1DqSMIq
         kqIgwGY+zyTLbjO7fGDZp8e4Fc+jtiZmq4gXp3/1Mtduks15cFG3jJVVmFfYtUQW8OPB
         WrWIU2l6qWauVsES5+rrq3cqkSMZAISglS7BqhV7ifd2HVCqkOBl3Gd4T7i8A8Y6qIoA
         J6WI657cTL/XCp3L5MzyPP7lX9dl2Tz9ZEAG1z7zRC/uciS/R2xcBKk+IYKUuubi3SL9
         N1MyekYHma7eYoErDpJ006Z7uHUhNmEcEknqA1iQg5KHQBqBEhBdnsrgfluRqCjI4BZS
         z97A==
X-Forwarded-Encrypted: i=1; AJvYcCXqlpUwDgAG7HS1mrXzr0OyR/qbitc36U/l8oLdAHDAI3dXLQbCW+5izK4xcO4z8Gu+qTBy7YHfDHZb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VOoktWvdZ6KBgKC7A45mNOjJo4RmLCvL3zi6LQ7MinrLoWhD
	u+CPa6gaBF3Yp9xFoV/VRO7GHj45Zmh8nNq6RPS41Ei+01MT42N7vk808TaawUQeCyo=
X-Gm-Gg: ASbGncut5anSzRuQLmKewumxXYXov0o6DX0VFb5eD6AWcdYtSnuZu8XlGl3tjoFnA3r
	TqE3tEu9EVfe8C/YYYwlnuofRKKNn+nV9L4j62RiwH54CjX6TJeh7aF5inAzkXsbKpoWpnNBwdi
	kZvfMaN7RxqzpxLLK1GE047LCYpSPaxTXPsg1HCPiZlrV6Y2Wb0+k7Rh5MwBMMsmLpnJAPPk3KK
	a/VpqARcE4v2SeLldSdZ3hrQFR15l+WN4AFhkyRwU05PJieyaI12+SG6Druw3/xFIhYNZsbW+Gj
	syUqIOWq1zM2g2JDyZ1eCuhqZjrfKEXQMsXCxyIrTLUjPxd9geS7iraFfIJvMrwx55irtnEGhdO
	EN6u/jjlANeYEsYWFv/70dvQ=
X-Google-Smtp-Source: AGHT+IGhFrGtTaA15Ak9Rt55rthx75V2hEys28dUdZBwQDdG7cdwzE2vVbKAh1/lzZb9pSxKOega7g==
X-Received: by 2002:a05:622a:5506:b0:4b4:9169:455d with SMTP id d75a77b69052e-4c03c1957d5mr174141471cf.7.1758552528540;
        Mon, 22 Sep 2025 07:48:48 -0700 (PDT)
Received: from localhost ([70.31.54.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4cbc4ff4e84sm16088711cf.42.2025.09.22.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:48:48 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:48:37 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Andreas Dilger <adilger@dilger.ca>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] doc: fix mke2fs.8 Extended Options formatting
Message-ID: <aNFhxYzXHquLJjTV@maple.netwinder.org>
References: <20250920225030.29470-1-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250920225030.29470-1-adilger@dilger.ca>

On Sat, Sep 20, 2025 at 04:50:30PM -0600, Andreas Dilger wrote:
>The two consecutive .TP macros cause bad formatting for the
>remaining options.  Remove one.
>
>Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Reviewed-by: Ralph Siemsen <ralph.siemsen@linaro.org>

>---
> misc/mke2fs.8.in | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
>index 13ddef47baa3..4532a33079a6 100644
>--- a/misc/mke2fs.8.in
>+++ b/misc/mke2fs.8.in
>@@ -369,7 +369,6 @@ be 0, 1, or 2 backup superblocks created in the file system.
> Create the file system at an offset from the beginning of the device or
> file.  This can be useful when creating disk images for virtual machines.
> .TP
>-.TP
> .BI orphan_file_size= size
> Set size of the file for tracking unlinked but still open inodes and inodes
> with truncate in progress. Larger file allows for better scalability, reserving
>-- 
>2.14.3 (Apple Git-98)

Regards,
-Ralph

