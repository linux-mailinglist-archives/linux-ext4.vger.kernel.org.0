Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D22216E6
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 12:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfEQKZL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 06:25:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44005 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfEQKZK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 May 2019 06:25:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so6513920wro.10
        for <linux-ext4@vger.kernel.org>; Fri, 17 May 2019 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C0Cpfr3qIzMoBN9F7dCRlBuwVDMbdHyBOSFIiovRDi4=;
        b=lGozGAVT6NV578F1RzGEJ5j0qtWiEnKG9sCciG36mQ5KGoqMzsGXouPGu0l5/5ZjNx
         LEfjrg6DYvdDac55rlSbZa0a2hG/EFFUxxPfmDo30nI3yPErbz+CbgWyjTiyUQ1QAvR0
         0+N4vMHrt/gewYJXOxAubvB/1rbfhaNlqEq9uuO5KpGWOkjWGHWrYUUtuw3fZbj7l9kh
         /DdfQP0nSQallHVUc3QNn59Rgejbavp4WEqYDtgdFEu7mr26XUmZrOC6qaUtS/99kWH5
         MjsdlMEDs5LI0e+GaojmtgCYTfG7ffayRs4wL85zCnmBvJuYj8ohcgVraOUapX0YnC8L
         9zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C0Cpfr3qIzMoBN9F7dCRlBuwVDMbdHyBOSFIiovRDi4=;
        b=TKZJ88M99OSuy2WYfOG9zmFRrgseCMGObbfBI/6TujXQgVH2DM+/S3PEvL8r0Iarh+
         6MoY5kDysv08eHPITNJlBmF5kA1ZurMZLpdmLkMNBr0lqYxbBmZyWjF4KxNmnm1zr1Qb
         U5K9CZPaQMI5ssmXNBYo5f6jliqqmpJ9ZoGujMxRtcmGK/D9xOJoaASSx5vvgiZrSJAC
         aTZy0CUKL5eU38fSrY8H0Dn+G6+AcEsiJr65YBogRByFb5DuiHC0NGmJzDXiFcR62FMF
         FwQPwr/sjVVrHP7w4yfzjIEWhXtFQgGd66brPjiusyVTWtW9Y/pfuGx5aZNo4GnC2FnX
         lOyQ==
X-Gm-Message-State: APjAAAXLTk80gFNXpCsI3dP+pMS1kN1/XSzg7sYBowPt2F7pN5uEp/lE
        mUbC52AyBDZZ+TzTp6x5p1cm9Q==
X-Google-Smtp-Source: APXvYqwOb+X2mA+dOQaG0YzpsW0k9MJlUgWO6AvHUfV9BtYZjbQHVhkNioaQSFSv0axslgMmgyq0tw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr3589289wrw.309.1558088709007;
        Fri, 17 May 2019 03:25:09 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id a128sm7769973wma.23.2019.05.17.03.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 03:25:08 -0700 (PDT)
Date:   Fri, 17 May 2019 11:25:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190517102506.GU4319@dell>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 17 May 2019, Philippe Mazenauer wrote:

> Variables 'n' and 'err' are both used for less-than-zero error checking,
> however both are declared as unsigned. Ensure ext4_map_blocks() and
> add_system_zone() are able to have their return values propagated
> correctly by redefining them both as signed integers.
> 
> ../fs/ext4/block_validity.c:158:9: warning: comparison of unsigned
> expression < 0 is always false [-Wtype-limits]
>     if (n < 0) {
>         ^
> 
> ../fs/ext4/block_validity.c:173:12: warning: comparison of unsigned
> expression < 0 is always false [-Wtype-limits]
>     if (err < 0)
>         ^
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---
>  fs/ext4/block_validity.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
