Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8367E614C
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Nov 2023 01:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKIAMb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Nov 2023 19:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKIAMa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Nov 2023 19:12:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FC2594;
        Wed,  8 Nov 2023 16:12:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507ad511315so409485e87.0;
        Wed, 08 Nov 2023 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699488747; x=1700093547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=VdTxfrx41ziQy4Nz7BCYpyno8cfIsO7U76xciSyVgh5a8B23uNs3Go3k9HEj48SwVm
         8NleB38sE2fmXdqAmEKcZR+acVFCpHJywyXXtHAdqZw+X9LgqVGI5qF2fLq5Y724uZku
         fEujXwZT7I1vkZLNaYWk35UYWMHVyqvMZWywv5PTYU5RLSh90JKMQnSsV0XcRPufKrVC
         YSYo6U1E3PdNWMoIjaCErkRR1ioaHFxgy+lY75T77C5lLZbU+G3i/IFBGUMHFy9a3t8c
         8EJL7k2Z0ymCWZb8DqgE/7l0AmzStPa8vgszGR1TohOMWWAiY2V4WTfjJNgi92p0Tc6x
         q7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699488747; x=1700093547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=ZIJ0Z3/30m//Txqpj0+P+i43k0Rb9BJvYaRSE7Ml31CUFh5wxO8Id8TZbfnfeMsB3U
         WsP27Ljl+gMeyHBdrh25hussO5g+w8cj66WeuCiZy9EwpFk8arj/o7EW6l5+CsvKEaxG
         pE9PHPe6QR8AANjlb+uXCWEjLI8N5RHBIS1Eh3sylxACQB+8CjaIRWKazBO0bHOMP6Ov
         9NkHqM5gXClAUqnqcW5Tlhm98nc2uV6rq9FeVJU+8Z3rGhfYFO9VvzoPPgDyhwDG8HAP
         w1pyLD06nXunh0uswo4APjYqyByb42qZVMOYfO9CbaunYrvfGjN2Hmg+FR0Ksf9t2TuO
         ubAw==
X-Gm-Message-State: AOJu0Yw1H80Pn79WauonKupGxBfBXCWgvTEDJJ/a4fLavXcFWGfw5ZtK
        qsIphDJri4yPl6sdoiBMDgH10VpTKO57Co2AIYjeMv1UphY=
X-Google-Smtp-Source: AGHT+IGMym6s82sHBjvRZ1gVgP42jaL1JmjVcnC8voSpb7JFI9R5aRcHobWV5Dojv1Zry9WdFGNjuVaBWNGJSNkxkfg=
X-Received: by 2002:a19:6713:0:b0:508:269d:1342 with SMTP id
 b19-20020a196713000000b00508269d1342mr109419lfc.35.1699488746448; Wed, 08 Nov
 2023 16:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-2-willy@infradead.org>
 <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
In-Reply-To: <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 9 Nov 2023 01:12:15 +0100
Message-ID: <CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>, gfs2@lists.linux.dev,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andrew,

Andrew Morton <akpm@linux-foundation.org> schrieb am Do., 9. Nov. 2023, 00:06:
> > +
> > +     if (folio_test_highmem(folio)) {
> > +             size_t max = PAGE_SIZE - offset_in_page(offset);
> > +
> > +             while (len > max) {
>
> Shouldn't this be `while (len)'?  AFAICT this code can fail to clear
> the final page.

not sure what you're seeing there, but this looks fine to me.

Thanks,
Andreas
