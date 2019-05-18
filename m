Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C26221DE
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2019 08:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfERGij (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 May 2019 02:38:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33702 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfERGij (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 May 2019 02:38:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so10596558wme.0
        for <linux-ext4@vger.kernel.org>; Fri, 17 May 2019 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UjvV69Pw38TY+UWCm958W3BhSAELE7Lrbyek85Eb+1Q=;
        b=ySHFdMXrg33fBSHehaQMTmzJVaqwtm+OJZocGViEljI8nlSfI28hu0S4MMER2QcMZK
         vk5yH/MYOXm5qtMxKvtGUORTVQx90c/v9BAksqNfMJe8tqNDsQ5wKV2BO1vJ4fY97Ntr
         Kwut1D0y0jHyK1mdhN7xpam0WMKzVFLvwSMAlXydRFkD0MMzCihW72p4fEMRE/p9Psc3
         nm0D6NPG1oU0S9fVYGvRdA6/TfmcJ8zp6DgkF5kJOZGv/WWJYtIRQPIAlL9b/ObdeZLE
         jrtZewLcINorntjfth3JxuckQcPW8F/qjJt6cc95bcdmokb+V3PIOwNdq5uFiF3R2x8E
         0cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UjvV69Pw38TY+UWCm958W3BhSAELE7Lrbyek85Eb+1Q=;
        b=eAVDsv60fuPN9uFQy8DJAaeW1Qzz8UnDR/45MWVyBf4HnKIWRT/j9T3OVQd7WOTBIa
         gN7uJkkwj2BbMA1Vew2ayPaqD8accX8l948pbsRdxN+Wx46ON5+hQcBOHcW9fpobCeuj
         GydDRtCG7wqnB+Ntio0tcUHyLXK10a7E1j2PjWtlvO0HYwoxsablB7L7xCJ4FNCI/JNf
         WIiQ3cpr+KZPwl2tn27vlLnp/5Iaz4jkaJ3xDgBXT7rJFWFkZRNnLOX6N7xvQd6umvFQ
         EeQcieKMU9bKqkfG/QwGtmN2JIDB+IYRDBlctwUXXNdSXRbnifkMl1SIPZRs5LljAjz5
         W/SA==
X-Gm-Message-State: APjAAAVqSzlIn7XVwUBSh4ctfWl/tW5P/TNZk0/AQiKsdjGnrkD6k9DK
        iXog/nRh8M1KlJHXdOBVklM7qg==
X-Google-Smtp-Source: APXvYqwNDJIp4PvB+a8yC5VIFYDeUcjM+xuvOJLOkzug9UL4qIro5CmakUjLQd5a+rNQaZRi8yCwEQ==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr35374564wma.38.1558161517515;
        Fri, 17 May 2019 23:38:37 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id m206sm12881593wmf.21.2019.05.17.23.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 23:38:36 -0700 (PDT)
Date:   Sat, 18 May 2019 07:38:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190518063834.GX4319@dell>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
 <20190517202810.GA21961@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517202810.GA21961@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 17 May 2019, Theodore Ts'o wrote:

> On Fri, May 17, 2019 at 11:25:06AM +0100, Lee Jones wrote:
> > On Fri, 17 May 2019, Philippe Mazenauer wrote:
> > 
> > > Variables 'n' and 'err' are both used for less-than-zero error checking,
> > > however both are declared as unsigned. Ensure ext4_map_blocks() and
> > > add_system_zone() are able to have their return values propagated
> > > correctly by redefining them both as signed integers.
> 
> This is already fixed in the ext4.git tree; it will be pushed to Linus
> shortly.  (Thanks to Colin Ian King from Canonical for sending the
> patch.)
> 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Lee, techncially this should have been Reviewed-by.  Acked-by is used
> by the maintainer when a patch is going in via some other tree other
> than the Maintainer's (it means the Maintainer has acked the patch).
> If you are reviewing a patch, the tag you should be adding is
> Reviewed-by.

Actually, that's not technically correct.

  "- Acked-by: indicates an agreement by another developer (often a
     maintainer of the relevant code) that the patch is appropriate for
     inclusion into the kernel."

And I, as a developer (and not a Maintainer in this case) do indicate
that this patch is appropriate for inclusion into the kernel.

Reviewed-by has stronger connotations and implies I have in-depth
knowledge of the subsystem/driver AND agree to the Reviewer's
Statement.  I use Acked-by in this case as a weaker agreement after a
shallow review of the patch based on its merits alone.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
