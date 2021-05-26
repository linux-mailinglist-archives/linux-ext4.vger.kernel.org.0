Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20273911C8
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhEZIEN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhEZID7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:03:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92FC06175F
        for <linux-ext4@vger.kernel.org>; Wed, 26 May 2021 01:02:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso14946772wmm.3
        for <linux-ext4@vger.kernel.org>; Wed, 26 May 2021 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QKYMHuHj0rbRUvGsShexdweEmy0NImIy2gA8dj6fkuE=;
        b=T5q7OTy6oO8Uxl4kJVPH+6k/22Oq4u5P5Syiyrm8N0Kkyl8yxvHJdzDg+3eN/NxRBd
         WFBgJEUvgpwQcSqbSbtepgsp6dCbHn3dD2+MR1kvmhmpVmSqDVOGAlGiT57y4is4cVKs
         kHbmcqWUi6HRepE51rTn7K+2enZHmTPlkL+Q2x4FhF3CPkZkJg8WQYnUQD6aqC/eWcp8
         soGqlEfvI00R3esiCgOJkykUeB1HizxPgfxD4BYr9CWoTtkuhagdPwb8F00WNQrHSRXP
         UETyn+MIeQvCxDco5L7UsXru93iZnIPVVTDYhug9eEhb4MUAJ/dec73GEj3k0XZmY84x
         etWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QKYMHuHj0rbRUvGsShexdweEmy0NImIy2gA8dj6fkuE=;
        b=U08x8tUN8Vh8FEIYLRaeBzAHq+S+n4ovFkl21J9Yh2vgutQbB8b9LYrqFzatAECWnK
         1w9agEbgfMiliqeS6O5GzOdUqzrTxgwLgWItXoCi4oaW27y5HlLOJYbfvIucfrpjwXqV
         8M2bIs/NJWAalAcmoe2OSk9HJ/A7Y4Z0Pz687GKVvnvm+2EkFjxxNrTQlNhLCrx6CA9N
         53YXFlk6xYESTPAuChPqjY7cc0HjbG43ypeoNddfq13ESrVrZIC8t3CQRH/T7JDPesgK
         Q+bMk3O0J/+O6mQnFd1xhkGn2zwd0OydT8FnZtoG+BBnF5HjFfuIlgx36tNaoMty80+U
         ZiQA==
X-Gm-Message-State: AOAM530L/ZjX7hXvikd1CTELZcgJYez90RSm2EfEoEYmid8+5TQCNfeM
        UUknaKsxJUTjA5HVnZsk4tCbCA==
X-Google-Smtp-Source: ABdhPJwrEx+pejVdZrENSeUjbsMmHQqcH7okPp5KpG7TvcFBGPoRuHHoqjtEN+zZbUOLp+4rBgmJNQ==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr2146740wmb.51.1622016146591;
        Wed, 26 May 2021 01:02:26 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l13sm5033812wrv.57.2021.05.26.01.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:02:26 -0700 (PDT)
Date:   Wed, 26 May 2021 09:02:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 0/8] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20210526080224.GI4005783@dell>
References: <20210121230336.1373726-1-satyat@google.com>
 <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
 <YK09eG0xm9dphL/1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YK09eG0xm9dphL/1@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 25 May 2021, Satya Tangirala wrote:
65;6200;1c
> On Tue, May 25, 2021 at 01:57:28PM +0100, Lee Jones wrote:
> > On Thu, 21 Jan 2021 at 23:06, Satya Tangirala <satyat@google.com> wrote:
> > 
> > > This patch series adds support for direct I/O with fscrypt using
> > > blk-crypto.
> > >
> > 
> > Is there an update on this set please?
> > 
> > I can't seem to find any reviews or follow-up since v8 was posted back in
> > January.
> > 
> This patchset relies on the block layer fixes patchset here
> https://lore.kernel.org/linux-block/20210325212609.492188-1-satyat@google.com/
> That said, I haven't been able to actively work on both the patchsets
> for a while, but I'll send out updates for both patchsets over the
> next week or so.

Thanks Satya, I'd appreciate that.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
