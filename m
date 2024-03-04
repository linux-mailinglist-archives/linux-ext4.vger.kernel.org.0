Return-Path: <linux-ext4+bounces-1502-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2838709F1
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 19:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82C8B23B7A
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64178B4D;
	Mon,  4 Mar 2024 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ograewz5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61278697;
	Mon,  4 Mar 2024 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578543; cv=none; b=UzHmH/xQnP5EcMzQsPREXvuFVL/HK+eYUIFmyta/wQc5bem9Lgwy+yU9XUtrvyEBN72g+AveAvHZlowUmCxXEt9yImrZhxP0jqP/UP1tK0yYpGfv/zuNsSQG9bLlqRWz7Z8/426wbUE76vJN9xsLjqk9hV713leO9cBPTziv12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578543; c=relaxed/simple;
	bh=XbxiiFgDK0vdiV/whLcXaY695CjT99BDjt4w3abR8dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk2jabDc6PlxnIjZdbueQcHkZjy56kIo12HAMf/ycC6d3iKJkfdI/RXm83aevFRZQEwO00K3AcLnmSEcp4B+voQxfGDLJDFbBGv5y8zFuzkPyzCdtcPQ6D0QyMw9XkBNKUYUlsRlyIBv65ZyIGEwWKluU25DmkYwZGePSEQ5XS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ograewz5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e5eaf5bb3eso1554471b3a.3;
        Mon, 04 Mar 2024 10:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578542; x=1710183342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWHd/MntE8Rmd8LhJvZq5olxdGIuCDgegi3GI3EfjqU=;
        b=Ograewz5LdafwDWGs4QqmkKwpjbHWUJZzjXElRWN7bgdX5CpM2/p1FOTTBgwFzdCPx
         sPWYRrPFQC662kLSm+nAMgYXTAibSj4xT5s5cFjwjjfkXFfigMPRQq6wmzpscpsfOY0L
         ha1971XtXIg2x/F/Dka5k15/piw+dxX9Ab0NkDnqH8HBCwLDonqplE1Y3s80b6HIYj8X
         OWxDPWvg+btOnKCjwRg+Jt6epG+utDBRoIO0YtZ5FeMOYtzZS1rrJoBmAfeFthBXpfrF
         zpUAWzeBHUZAaYBtc8wX+Ui7ADmEqHjgwV8tgAywseSLrl7FJpCaa8SC9u078gTJqwF3
         wkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578542; x=1710183342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWHd/MntE8Rmd8LhJvZq5olxdGIuCDgegi3GI3EfjqU=;
        b=v+XJllDLJglWH7kDqx7oxZo/nHJCMvmPxZN74Rb2EyQILM5C+jgJeA3fzooBq+0G4F
         WsfjWCYaPvQFbbXnaaEtLGMgBFpF2ng/7JRSXEr1y7JneSb43ULdmuRn0n3ZRt1v3GFG
         r/91VmZyUEqYndmFgIoXm4mHajK55Xk5fwVUmYeF1++bNxwVSmhCyDpTYpTUlGKKzJVO
         a/A9phz4fFQJQQDoqaGZR2pLNNiuEuGJdFwPxHZYlg3uIxo8rvKnIULKebd7TN88+Z8e
         wgt4Tg/vtsytmqsiUPHU3mX7dIQ8RE6FmiOdD/ysKuusoID8a1obY3E4ckKJREdgyKuP
         ZYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaRis6XbyFXoPM5Sf/ZhQQrjyvAkz4vhOrVEl6p5KxTsmaJzb/LotfugDamhHUf2yR9olp851Tc2lqwEQ1mL08ARNPjMwsvC/1Whs/wk+/WsoMEeMrrb2XHBqZjM5WSRvzR2Jc7A7zmg==
X-Gm-Message-State: AOJu0YwwP77w0QS7KwRHqEdEZCZPnlhzP/WEOqisR+XOoszaj5IgUgwj
	okLIHrfLJeqRuw9JKWlFtyiX+xTDkHYAJakCH0DJS8UC9c6ogjD6zhII2yIQ
X-Google-Smtp-Source: AGHT+IGOyMhE3txAqz+ylOvlTN+mo2NShjbABe2PZn0fnZC3cF0ocR+dwXrjmUZNdvMGOeY3aNTjAw==
X-Received: by 2002:a05:6a20:9f8b:b0:1a1:3d7f:ab64 with SMTP id mm11-20020a056a209f8b00b001a13d7fab64mr1954421pzb.37.1709578541615;
        Mon, 04 Mar 2024 10:55:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k23-20020aa792d7000000b006e5a09708f8sm7228220pfa.174.2024.03.04.10.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:55:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 4 Mar 2024 10:55:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org, brauner@kernel.org
Subject: Re: [PATCH v4 2/3] ext4: hold group lock in ext4 kunit test
Message-ID: <49cdff8f-65b4-4784-9789-34af07ee40c7@roeck-us.net>
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
 <20240304163543.6700-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304163543.6700-3-shikemeng@huaweicloud.com>

On Tue, Mar 05, 2024 at 12:35:42AM +0800, Kemeng Shi wrote:
> Although there is no concurrent block allocation/free in unit test,
> internal functions mb_mark_used and mb_free_blocks assert group
> lock is always held. Acquire group before calling mb_mark_used and
> mb_free_blocks in unit test to avoid the assertion.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

