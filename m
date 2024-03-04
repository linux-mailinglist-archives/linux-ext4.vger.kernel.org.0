Return-Path: <linux-ext4+bounces-1503-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575038709F4
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 19:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D137FB25D8C
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE75A78B50;
	Mon,  4 Mar 2024 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwgn33wd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FD78688;
	Mon,  4 Mar 2024 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578558; cv=none; b=oHOAxRx8JGsPExuu+qg+YR5RlWXAWCHSwWcKJMJbyu2I6mbBPw2Ev7+S7yULSeuNUO3lQR6FTqWGTC9lgu+m9+kcd63INi4vUBZ/yTbVItGxJUa4qketZl8ti8IIp6vtZ/Pd9HqGqOv27SsyQ+6WCYnx4A5z7xLKl8ipKKyVQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578558; c=relaxed/simple;
	bh=bGKnzitZArijvL9g3fzz6a59BbPOTjf9tQjbCrOYxj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9uc2LKLXw4DJsLD84Zwlo27omeiIUHcaPFaHKdXR8F9t3gV3NyP75epvfpCaepteSTOCF//2b+w6ZajLmQ7/dp73ZsCbk5TchnCLvUWeQiJTriYSM3LYVqhxnJmp34fvu+RMWx92zCJxoNgYS7NzQ6YLiBPBZ+FQjCaTDGdLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwgn33wd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e622b46f45so1002034b3a.1;
        Mon, 04 Mar 2024 10:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578556; x=1710183356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd5qc8Km15KNV6bPSOT31D1lIprfjOiZpGb5QhbtTm0=;
        b=Kwgn33wd0svZuMgqrxhxesrbo0CxdKp7kvwQubQbl+u3QiMsXZCfzKzRNcWd8075KQ
         thna22rMii7lPab34ZMehm1I8KCMonVGulOLwvjUhZBEHtLQhwpZ4loD3z25mAQl0P7h
         E/twuEQdj0USXivbvb1Sk7+pDxwsp5Hs3kky/HCY07ppruRetGrfHTfcEh7OEn1Y9TfD
         OiV3dmFkqzPuKNdHLTIwVrvujLTw9m4Hld76oE5icTUHJmqOmnm/+yMZDOWuENOBnva8
         zh/WdVbaiik96oL33sC0LINo7RV0uHDtfqQVDd71mjg9eyCE5hLHF937XY5YAoe6igqD
         qpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578556; x=1710183356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd5qc8Km15KNV6bPSOT31D1lIprfjOiZpGb5QhbtTm0=;
        b=cdJ1mxDnHFdtFIQreRAKY6liHiM2puij74/S4+H+A0wq6yftnQn9c+vRH+b9ytvdql
         /pq/wNPCxl7eLucc9R4KAEDoJblP1blOyyUpEzZChHQapRLNEW1IUIktCQ+9PD651SIq
         4BsLVFUoiQU6uqjXCnzZ3X2yjh3vKrkkQOXHY74Ei3dQaFIz+f7rmAToWapDG5LCLqSl
         cPu6y073m21RgIvmtw2/ibiMmcdDwnmBbIwc2jfHvJenw4NYa+YpY1oVUGWxOGc719w+
         /hdM9R3Q8z3Ol8lwuq4al/A2o/+x7YRI62zbwzX8FiLDUqq7ia9vooOZEuPgaR/O7nuv
         +ysQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzg9yjmSyvcH0cwxfSF+VTxWfR3YVP3ONE5hERt6tb1CNj/QMXllbmEvT+H+R6AvE1BzHNLpfES/VkQ92caCbrzi2yxEm6pz9CJAyROKH0isTnH81v11Bi4OhVH8ZdXmo2OEfNAr4WhQ==
X-Gm-Message-State: AOJu0YwYNXOjZ37QXtp3tupp6jU1wwvwlsTho5vMVG6RLSpGuL9Xp1wI
	kBRkZ8XLhA5OOWqMyr/UbbT3D7e+Rn6kPE1SKpGgKg0oixEFfLxLPgRtTuDn
X-Google-Smtp-Source: AGHT+IFLv7EawyhstGPKMyvZgfHs2RJ/bsO1dCAYq4K5ztCm0v0NGezxFvOpKgSC/d/nNZr2u7mlhg==
X-Received: by 2002:a05:6a00:4fc9:b0:6e6:189b:a3a4 with SMTP id le9-20020a056a004fc900b006e6189ba3a4mr3892541pfb.5.1709578555119;
        Mon, 04 Mar 2024 10:55:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006e5a6e83f8esm6666222pfh.134.2024.03.04.10.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:55:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 4 Mar 2024 10:55:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org, brauner@kernel.org
Subject: Re: [PATCH v4 3/3] ext4: initialize sbi->s_freeclusters_counter and
 sbi->s_dirtyclusters_counter before use in kunit test
Message-ID: <62b092a6-764f-4140-a586-1f6a94dfea36@roeck-us.net>
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
 <20240304163543.6700-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304163543.6700-4-shikemeng@huaweicloud.com>

On Tue, Mar 05, 2024 at 12:35:43AM +0800, Kemeng Shi wrote:
> Fix that sbi->s_freeclusters_counter and sbi->s_dirtyclusters_counter are
> used before initialization.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

