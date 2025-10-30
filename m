Return-Path: <linux-ext4+bounces-11346-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C940C1DE07
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 01:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DE16348EB2
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 00:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0613D638;
	Thu, 30 Oct 2025 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt1DagFT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859513BC0C
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783175; cv=none; b=YXVx6s0nZ17GncU517BmkAU14hAHW9BAmOJywXSA7IundJMXsQVStMF6ShSBB7LVcETVzjkjB3Eo2TFU8rIObNvyO+mMQGLXTkGsrp2LOAVdFsOFkQ6T8CRy7Ksn7UWmwwiMU0dFXHY5xnEueUcgQq3ex3O+AUobZLN2JvgZH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783175; c=relaxed/simple;
	bh=Pt+XWVpX7W4+wpuWhwGPAsTClncvQbYcOUcfu0ntAWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FejoxylyW2ItVYAWwnv1uW2kU2s3Celvkc8Frd2FE8SnuiVtfiFnDrsMeSuUwn9pHdZ7Y8RBTNIYejWjf4EBNdUPMOjXTs0LmJvJh4c2WYo4xKqbQiJ7Hx6dkOzil3RLQuES7VQxb5TViJ3cPrWGawn8pRd/zrnq+lmV5I321oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt1DagFT; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e19642764so637269d50.1
        for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 17:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783173; x=1762387973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt+XWVpX7W4+wpuWhwGPAsTClncvQbYcOUcfu0ntAWk=;
        b=gt1DagFTIEunIXXIOkOAgNqOmYo3zlgeR/je+tBx/FAKS/ZDZlNDFvfn36Gyz9wMTk
         sUHbr8F6/dxLOgw3lh51DW8Yzo3BAE8wBWJjPtkrC5yeOmLD7Lk/W2nB4vpzie1sKAtg
         XPGWpSbP/CLftAoANFwvTDQhp0ZJc4UWAh6pHba8ctPJsxZ3QZENRMwJV5kOipG47jGd
         Ti0bjZ2tyso/dOgX8NLPO+mPMGiaiWNaJun04oPylRjh+3bqYMP8i7gBXRLRgXgRLlT8
         S5EwVKCuTqENWTb59aKmRggY+d0r+ivF283LFjyohUb+gc+dLXTQV4owONLolC//VLCP
         /0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783173; x=1762387973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pt+XWVpX7W4+wpuWhwGPAsTClncvQbYcOUcfu0ntAWk=;
        b=aVbfmVq+zQ1lqscuy+VIR7ND0siIXJz79wadC/u99SeJAltYvdQkmtUOP6GhSQ48d5
         yg+pDyLTHt+Ivgm0QXytRTT6ROS6k3WHh+4QQCA8437f5PyUWvFao1hksqzKawxfMGf2
         j7IlJDK7mlryL03RpJyV9GnLXgoV7Y7Ky0qVFeIsqskiSxOD2dMua7pOdQ9PLT4944p+
         +LWm+5e84+0FW+tsJR9W6W5zLK3i4q7fm2OWpKjrpjpq2SFwZiN6PmezTbibhjDZzjD3
         QT0XNQ65xYghAUA+y6syAbOqI+bZUp+sHnPwjlbl4s7yjQtn76lcIWfVfONZ2a70+bM2
         0JJg==
X-Gm-Message-State: AOJu0YwtMDQcckqxNJlnBXDAVreWAjPyk9C0SHaQFrgwTlJGGnakoZ/1
	jsW2TTpODPvv4qRZ5PL3VfhZQhRNjUQV04mf8+N8elkt0eSDRV8eS8L5Ay/FRxtGIpz9aCPynas
	ybwIGZ+ZwMgfk6OkRmId+mLi/jo458fc=
X-Gm-Gg: ASbGncvOJvnh5z3AVJMxDSQHLjCuCAXHRTLnGdUwXMK7x+MbeOvIF6alEwqp0d1WUj0
	xCVqBYGkuFJSGPFoGTPu1kW0HFSxOUDMokfoWJG/KopzxIvmRVp4Ywn7/tUOjMGeKS8lWj3pnIZ
	lTiNdN+8OYtJP6XT328FOAR0C1fVG5HBF0D+GQ4wuH3g7bKu7kDiJJdbetOr5v93lznBlcbq0YJ
	QXnaIPrdiT8jDId7QdHE7oyb0ArCp+H2A7ZsqUGL5ug8gCGN2FC4nVgNtkS0EPh8RNDxxdpJAQB
	C0kl2Dsd6ZXSR5k7q34Gu3kbqw==
X-Google-Smtp-Source: AGHT+IGkcPVeUHOyzzeaDCgQVV7N1DsbtwKzZjCLECXQw783opykaLZ09jb2jif+KNRmNzEauIlnK78eUmwkI+IK53E=
X-Received: by 2002:a05:690c:6d8f:b0:782:69fc:3911 with SMTP id
 00721157ae682-78628e531d6mr50674607b3.21.1761783172633; Wed, 29 Oct 2025
 17:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020060936.474314-1-kartikey406@gmail.com>
In-Reply-To: <20251020060936.474314-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 30 Oct 2025 05:42:40 +0530
X-Gm-Features: AWmQ_bnMfR5x5ZdWlkGeeYXa0-DzGpDM7pDrxlQdwW98XmHQJqd2qfcHjX0iTHM
Message-ID: <CADhLXY4GzRDC0ReKwhy50UAfwugvmBb5ffsuCQG_7GNDk3NcUw@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: refresh inline data size before write operations
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Theodore and ext4 maintainers,

I submitted this patch on October 20th to fix a race condition in
inline data handling that causes BUG_ON crashes:

https://lore.kernel.org/linux-ext4/20251020060936.474314-1-kartikey406@gmail.com/T/#u

I wanted to gently ping to see if there are any concerns or if any
changes are needed. I understand maintainers are busy and happy to
wait, just wanted to ensure the patch didn't get lost.
The patch addresses a similar issue to commit a54c4613dac1 by
refreshing i_inline_size after taking the xattr lock.

Thank you for your time!

Best regards,
Deepanshu Kartikey

