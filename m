Return-Path: <linux-ext4+bounces-7112-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE0A7F90E
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 11:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23D23AECA7
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F856846C;
	Tue,  8 Apr 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxqLj2We"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED02641C2;
	Tue,  8 Apr 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103529; cv=none; b=I2GcUzhN0ebgf7i+5Ee0kIAnU2G4A76rOYNiD/ImcGKB3ZIK7C+uvRK3kxtiu838y4BZtWlBFufvCJk/eMFfxPGq+nplbGa3YnWJQQYRJEgmr76a2nkrl9lVYvWGUK3lGhaJTM5ThagMwfctmqVdKZbA1CNUa8GpcbCo6Up9JpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103529; c=relaxed/simple;
	bh=YirglLgWBFF0qfJs3ffvKSg2WkCDvxyqAZh6NrDJ2vg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=DQdqLdJO0uq5I5iLiuxvRYvXv4w6bRYpluI1bAnunQbLbpqBBN1YNyktfHIbM5fLHmlImb6Y00iCn5U/WyrRBghohGH9jScEvKPSXD8w2NSZJG5oAIBMCQ0iVxhiR8G64R8dydx0utNm3vsbvt5p1ALbkhcVxP+rnc7Adt3i4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxqLj2We; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c062b1f5so4343761b3a.0;
        Tue, 08 Apr 2025 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744103527; x=1744708327; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uq8hjxnX37tKxBSuH0zUWkPG1Hr3Hz/M3qER/pEY84k=;
        b=cxqLj2WeylAKIejI4b+McdirfqnhWd0Im4pumThsPyhJ2sJj8OytkXCCQv88rECtJ+
         VeJLolrGt0Z0pccZuL86n1bWDd+YvRAdrPIhDGKDChMLsRAIeWHu7/uqERBsIBXOIQND
         bOTESiaQIaaVKMXKeApe5bUPgtm5y5LhYcsUBEsGw0gnjSYxvlp3GxQL8jfH23++nnFD
         RtBguZOgmrSWYGDLYwgpBUoGF3zbunOqP2U/kglER8rAShrgSrmY9UDa64l29q+5Ome/
         0gATEV8D2TWjlyHSRcNKjzb24zFa2xe1fESI7pjvudKdkBk+2z3O1yUv4qy+yAGAk+CF
         16gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744103527; x=1744708327;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uq8hjxnX37tKxBSuH0zUWkPG1Hr3Hz/M3qER/pEY84k=;
        b=BR7t7wxDqinYrWPixl90E+dxo8fgrclld/pVCLHI5KeD57d2mSwF3BT+X6w3b7E8se
         FOsbVBEeOr9G+TPyeq9Ci48RPcoDBtPVV3KvurTIQgkN6dtkJCUHIiev3kV2poP5ztSg
         xqpjcZ5DxP9YZyOEkvjpbT62wjj1wZGLQMetLoK7fAOl3gvCVt3QnhSsJdtbhqVicMmq
         u6kQXAcoLv4sFmlvzJsYp9hhKGPZ4vyR1XLMuWD9ft85sgVEHVyMyRW7EnLIbjpbUPx5
         Zq/nPpQN+VHJc9g7mFSCbUBhABvXvSETXahqL0R2IYBIXe/mO1L0tpYSls47/obmlXgy
         DXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWRHPNp2R8kaGo88DgSxphsOH1y/PTR+RwdYw+A9bj/qlQZgZgVTGvvR8qwVTpK/yFk4wED7laOCu7@vger.kernel.org, AJvYcCXwDNXQTwWo/c6tZjPttb3jAvuYHTtTSE8Gxeo1/5Ehcqs6LC7AymnKbCvxDWhZmE1yjSzKepGZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjM0lex1AfhipDutyOzr3FXp+FMGDRIOT9IqBoXnC0vzb7jmNj
	slQPQt1ZW/rflnbMGgCROaIxu9uJZf0HFJG2sQ7Ii6k81gtSoJH6
X-Gm-Gg: ASbGncsX581Axe330ctcnYuBvS4myRB2yCOrSAC0Xuj6dUpxIFZH15p8zvvnhWAi4tR
	9ZGZYEV16phJjdVuWZEZDebSU4xjfrLfvRuQcK9mgvJqiOZHLAnkJnGOW1Tieg1VByCMrYMg1EY
	q7NXiNFEoYNyp46Y/GmjHangnJUi6baulNZ4zSwTnLQMFDcpf+mz4+yUlfDBVCvK19fWIDSquW5
	C3xKt62B3yGioTsPqAlF0uA5SmJhQN+RE2hXwP0xt53cX9gUSuFtubansH8Duf37I259yhA4l51
	T8N7qNfDYVjYcgTg94Xk4KnGoVzsoM71zpI=
X-Google-Smtp-Source: AGHT+IFHG6OT/uU3V1mGre6jptl1dwSZWNC5CgaEH63KXZ8fKUX1DJXpJIxUa0rwArZ/PW+56ygEYg==
X-Received: by 2002:a05:6a20:561a:b0:1f5:9330:2a18 with SMTP id adf61e73a8af0-2010801c42emr19259765637.23.1744103527563;
        Tue, 08 Apr 2025 02:12:07 -0700 (PDT)
Received: from dw-tp ([171.76.81.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc40098dsm8715919a12.48.2025.04.08.02.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:12:06 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v3 2/6] generic/367: Remove redundant sourcing if common/config
In-Reply-To: <ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com>
Date: Tue, 08 Apr 2025 14:36:53 +0530
Message-ID: <87zfgrja36.fsf@gmail.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com> <ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> common/config will be source by _begin_fstest
>

Looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/generic/367 | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/generic/367 b/tests/generic/367
> index ed371a02..567db557 100755
> --- a/tests/generic/367
> +++ b/tests/generic/367
> @@ -11,7 +11,6 @@
>  # check if the extsize value and the xflag bit actually got reflected after
>  # setting/re-setting the extsize value.
>  
> -. ./common/config
>  . ./common/filter
>  . ./common/preamble
>  
> -- 
> 2.34.1

