Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F85723331
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjFEWb2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 18:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFEWb1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 18:31:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE603F4
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jun 2023 15:31:26 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b0d38ce700so4115355a34.2
        for <linux-ext4@vger.kernel.org>; Mon, 05 Jun 2023 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686004286; x=1688596286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc75ejD/B9ju2Ppm1yWUxALAa1mggaMhLldhOHB8pJM=;
        b=jGfg66fXdP9R5wZaybDQ0asK6vUO627vz1q5dHOQNr8M1tLVJJE6NVBOYY9vEGWF1Z
         G2D0ijldCWNK74Wrl/Mxlb6qxEknOgudO+i3eQ2EuOREPtBzLq1PyR8/UNAUZJB8M38T
         aQGpGFIrQbW5r3f80ybqsNBN0nxlNPbnhY87s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004286; x=1688596286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc75ejD/B9ju2Ppm1yWUxALAa1mggaMhLldhOHB8pJM=;
        b=YHWTLEzyDlH5olYin80MeAzZ1iIR7V6c40uDKlI8j9LPPpmqgwCEspKSjsZ9s8PRpy
         opZEOb/64j6BRetXL4Q9KaSobEdnNLbFPzelJSeMAOmqVDhInoTthjw4ljTro+hTK2J5
         2MO9afTaEGRZkUZyvsA3yczyXYT5xpzQy8qYd4Gm6qqKq13GnlXbJPzBlzGI6AKEcae8
         XwIccDlSVSx/2MZJjCpxMgaOgc3p3HIk9C7ARWga7m7uqGcMl2CETcAkhMFIkPb2+SSz
         m10NMM+GbJJfZvu7CNPIj2rDkLxK8mQwiLyxlTsmKovckoYR6Y+awUVcRiRH3iIXbWWU
         fYNg==
X-Gm-Message-State: AC+VfDyISNcZNYQOgf7A6qZqtqD3tDM68mHF0WBMGvpGz+5d8CXJMAXD
        wemgpkp+f7CI6li4ICqAG5pSmA==
X-Google-Smtp-Source: ACHHUZ50kFXY6b6nPHFLD5yx8ofgsUJXKpdfqK2pU901ff3O0ybJwzXGoivL105WHg5fltvS5uobWQ==
X-Received: by 2002:a05:6358:c122:b0:129:7bf:eeca with SMTP id fh34-20020a056358c12200b0012907bfeecamr463657rwb.21.1686004286192;
        Mon, 05 Jun 2023 15:31:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx13-20020a17090b124d00b002560ab7a15fsm6284531pjb.36.2023.06.05.15.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:31:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, linux-ext4@vger.kernel.org,
        cezary.rojewski@intel.com
Cc:     Kees Cook <keescook@chromium.org>, tytso@mit.edu, jack@suse.com,
        andy@kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 0/3] lib/string_helpers et al.: Change return value of strreplace()
Date:   Mon,  5 Jun 2023 15:31:23 -0700
Message-Id: <168600428200.201645.8654517038188222559.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605170553.7835-1-andriy.shevchenko@linux.intel.com>
References: <20230605170553.7835-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 5 Jun 2023 20:05:50 +0300, Andy Shevchenko wrote:
> It's more convenient to have strreplace() to return the pointer to
>  the string itself. This will help users to make their code better.
> 
> The patch 1 kills the only user of the returned value of strreplace(),
> Patch 2 converts the return value of strreplace(). And patch 3 shows
> how it may be useful. That said, the series can be routed via fs tree,
> with or without the last patch.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/3] jbd2: Avoid printing outside the boundary of the buffer
      https://git.kernel.org/kees/c/7afb6d8fa81f
[2/3] lib/string_helpers: Change returned value of the strreplace()
      https://git.kernel.org/kees/c/d01a77afd6be
[3/3] kobject: Use return value of strreplace()
      https://git.kernel.org/kees/c/b2f10148ec1e

-- 
Kees Cook

