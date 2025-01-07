Return-Path: <linux-ext4+bounces-5954-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41404A03959
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 09:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E1216503E
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D21DFDA4;
	Tue,  7 Jan 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6AcyD++"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BE1DDA2D
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736237351; cv=none; b=AvAmNyjbX/RFkhaNGeKdtYk4Nmu0l8YtL0+/gyMRYh4i+IwNSz2fAEmJPYGndLS76omXs5xXlHNjyFrBlD5Q++WvqqNjMLe+KIi84JmKGBUIr7Dbe9o14Dze3xcPnzR0XdTvtDWc6ra3gbN/0k1OxYTIgvaz+s4CYpHQjdKnXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736237351; c=relaxed/simple;
	bh=ZH97IDHpNAx4jci27cm/F+Pns8CYOUaop8R67kRHEgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED68wv1+/UEkB2JI4RnsHGXJwo2GIqdGIpWmOIh9SM3YbdqkOQ9M3BppLaC02Czcprz4Yv3oooAxqPpRho5FwOtsssZVTYYm6fOm5iWTFnB8qpWY4+1dE5qllvumtamQH4FIoHSADPEI5cbC/Pkl5cz2B5RpoiXJq5J3uJw5LAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E6AcyD++; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361c705434so109681665e9.3
        for <linux-ext4@vger.kernel.org>; Tue, 07 Jan 2025 00:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736237348; x=1736842148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61s00L4+Bh0BENUBO/u8PhKZ1my5KDTfGobviInVbCU=;
        b=E6AcyD++7p1Jy0CxXLrnXQw1IGanmbKUGCObOht6x6lM/VnvrCuIMlNE6ndXgjgsai
         qwG3qPKpmAyKVjc8BFMBtjPi3VoQ0nlpXVK1RYvRyjr+D3R9x0sJ9BcwH1VOrqEc8lEs
         N70e9k16FNWgWJDG6JiAu6uRQ9fU9NC9Ol21tfr86gl+hfWu//0974d1pxFxkVYcZFHm
         q3KRAHkLaUN+8MFvdzMzOXBX3Vsi7sNqtwxfoNoaXBDz/ZY4bpUfHvuXXn8E0oHok6f7
         VC3y/2pC4DthpJrRHdZXZZ3Xu9fMgzEAflT3mGO5C2yGRMh2DdN2M81mzOIY9k5lUuOU
         Zohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736237348; x=1736842148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61s00L4+Bh0BENUBO/u8PhKZ1my5KDTfGobviInVbCU=;
        b=cBU1jfCLO4HDLKmHmR4XPW1/nVjSXP0vvWCpmvf61W20G5P+cIqRbDvzs8b+mzkVwI
         4W7laYDXY7Gokbz+k3uNmm18Zj2Tfx3Mnw7PCF6JykP3o4GhBCndrmpW7HfVRAz161oi
         tTp97EXkBiqkCpMkp2OrlNx0k2ev/C4gEVg9af1/9117YIQvHFlD1zk+uzW8msnpcxjG
         e9BVvnKILjDmLTDEjQjHYmyI7msNIUDq0cb03eYS9R3jb2A8cK+YV4dKvaVxY5LkHKJv
         UFynQcKwduRKmnhTu8mBeE6FOgdX5vIZPZv5C5ODHOyJUxzLsLRvwp2ws8kUbMa87C+h
         t1lg==
X-Forwarded-Encrypted: i=1; AJvYcCUPMcDmOW53UEVELL4Crc+IN2NLwRMInjaJNXNUR2id0WpwKiozFut58UbKQW58DQS8OXZDdC79Z2I2@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTYQLyrzzB2CjFzV0c2k5xf7QJt8Wpk/d/KHrmbZuhEUEB4Kx
	x4fYapwhmXuF2TuSv7/kYxxt4XMIfzq+z8mW6XML8GpqKyqYzpMllcr5m2rUYs0=
X-Gm-Gg: ASbGncsvV8gcAuQSvCuSAxdLysUoDoWSKUzJMJrgrabQzGoZSUiLfitMNyekOn+x3wU
	9MlFDR4r2U8iLreeMJrVty8jH2avDyspA7nAYM5UWwgAxVQIjxYG6H1iBCovBFaB0fReJ2ED2mv
	RfqsTmYiIhT8Dit0nmSPF/dN0WYkjI3eKBQt17OgQFYQuW0IAjO5fw/+v2XL4Bf2rYr6AXBqNlo
	NbLa+zKbXkzEzGNIXh/fkFuxkekuvAEhsQSN4wQtLVKLVX7gQvtYbdxefuplw==
X-Google-Smtp-Source: AGHT+IEsenbu2rKsRcIBHE7Ai++Ok2RotzvlANX0bu6oTbxzog2vVSczWxsWNk3+PKcJrVkx3AvWJQ==
X-Received: by 2002:a05:600c:510f:b0:436:1b08:4c78 with SMTP id 5b1f17b1804b1-43668b7a284mr555015735e9.31.1736237347868;
        Tue, 07 Jan 2025 00:09:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a71sm586050185e9.26.2025.01.07.00.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:09:07 -0800 (PST)
Date: Tue, 7 Jan 2025 11:09:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alex Tomas <alex@clusterfs.com>, Eric Sandeen <sandeen@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: Fix an error handling path in
 ext4_mb_init_cache()
Message-ID: <da3377fb-96f2-4ec2-942a-8a9d2741f261@stanley.mountain>
References: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
 <9383bdd6-ac04-4a14-aec1-bb65b67ace75@stanley.mountain>
 <2824a50f-33f8-4db0-a7c2-edc5d6ca12af@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2824a50f-33f8-4db0-a7c2-edc5d6ca12af@wanadoo.fr>

Ah.  Sorry, I misunderstood the issue.  I can't say for sure whether the
bug is possible but it seems like a reasonable concern.

regards,
dan carpenter


