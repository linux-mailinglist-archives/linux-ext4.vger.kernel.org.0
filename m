Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06C64448CD
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhKCTRi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 15:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTRh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 15:17:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC41C061714
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 12:15:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id bu11so3711591qvb.0
        for <linux-ext4@vger.kernel.org>; Wed, 03 Nov 2021 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IMMLA2kbTmW7Ecda1FnFdHE+pOJ24TO/koJkQdiO4LA=;
        b=FjH5S5XjiRCax7O2kcCHsh1TwdU6iGPkHBcUZyDJZFu9NYzdgSEANjnlVgDj0pMXim
         5bWP3DWrXCJgTp8HduCoN1dFeQYN2ZNdeXjq0JwXy9OVL0q3U4uevdsD44Tr2Zyd0qj1
         /JLWIfb845rHaxfJY3wiZoY+MCeLDVZVC4j2FHR5fkV2GDJss4+tylHrRNYFdqkRJId7
         kWoOKPwU1nbJN9FVciqrs7fSO2JVYbuOJuIVSbp9trpx3uDBX1Er0krSyWMHScxqZMSm
         zJnMArrReCtgQJnGmuWMCfhLaLWFKZjIqFG8K0XPLGBxBJ4z8hlDl2WxWC1H+LoOrc1B
         JFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IMMLA2kbTmW7Ecda1FnFdHE+pOJ24TO/koJkQdiO4LA=;
        b=txMH83wOMSlof955Cvqn9JewTbIMZZJosZCivCunLDaH6hNW7d6LJOYVQ3VMw7w5m2
         pC7HDdsMHPwJrTjO3aEBHAe39ZPZlaHcu4MwCy48IXehZdebOqwoCoeQVXUooLjNBXIG
         TSwmg5qS1TxX7kiP9ANkNZtW+UK+jbQNAM47VZ02B0pIOFxB0TwpEidcnGrvq0+F4zp4
         slrplLwnzh5q4IiBB2fb89e2azpA+3qKWcH3hsHAHL8MHjQNlPPilhW/E564GjXA4qXg
         svgQHhoxwpkJ5oOvOE012gMZgUdR3ClYmmpZqBnFJDBQOTU4fNoHMhFzIvOHScbOmxGn
         /ULw==
X-Gm-Message-State: AOAM532MG3XyLvklqZV0I8h3+++kItv6b8R8PRL1o4fwGc07DnTMgXNv
        Qe/L6FhDYpGtGGoufmor4ns=
X-Google-Smtp-Source: ABdhPJxLXxcmXVouHyxCzhpkW495otL7A8QKgxgm37Y430P8PN85oPRGiEqdp/cklgwDUUC10PJqfA==
X-Received: by 2002:a05:6214:6ed:: with SMTP id bk13mr45520880qvb.47.1635966899833;
        Wed, 03 Nov 2021 12:14:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id y8sm2141703qko.36.2021.11.03.12.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:14:59 -0700 (PDT)
Date:   Wed, 3 Nov 2021 15:14:57 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: enforce buffer head state assertion in
 ext4_da_map_blocks"
Message-ID: <20211103191457.GA3838@localhost.localdomain>
References: <20211012171901.5352-1-enwlinux@gmail.com>
 <163415796177.214938.9752602885736039327.b4-ty@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163415796177.214938.9752602885736039327.b4-ty@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Theodore Ts'o <tytso@mit.edu>:
> On Tue, 12 Oct 2021 13:19:01 -0400, Eric Whitney wrote:
> > This reverts commit 948ca5f30e1df0c11eb5b0f410b9ceb97fa77ad9.
> > 
> > Two crash reports from users running variations on 5.15-rc4 kernels
> > suggest that it is premature to enforce the state assertion in the
> > original commit.  Both crashes were triggered by BUG calls in that
> > code, indicating that under some rare circumstance the buffer head
> > state did not match a delayed allocated block at the time the
> > block was written out.  No reproducer is available.  Resolving this
> > problem will require more time than remains in the current release
> > cycle, so reverting the original patch for the time being is necessary
> > to avoid any instability it may cause.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] Revert "ext4: enforce buffer head state assertion in ext4_da_map_blocks"
>       commit: 52264b162a51eadb0adcb55297cf91905c6ede98
> 
> Best regards,
> -- 
> Theodore Ts'o <tytso@mit.edu>

Hi Ted:

This reversion isn't visible in the 5.15 kernel.  We'll want to get this in as
a bug fix to 5.15.1 if possible.  Please let me know if there's anything I can
do to expedite.

Thanks,
Eric

