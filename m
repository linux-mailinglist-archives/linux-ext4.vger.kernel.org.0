Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D453717B8A
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjEaJPo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjEaJPl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 05:15:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A5911F
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 02:15:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-514924ca903so6363052a12.2
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 02:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1685524538; x=1688116538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/bYqGFJ4VOGoB5+32Mcq8JR70Vd1T1ITCSeV7/3ifk=;
        b=UZJgvu6uIJY01EjK7iQN8XWB6pp1lB8CKfw+N0J9F6PgtqlKRqH1SLE+0gJUsS//CY
         frv0e589K6FPUxK3WlywVEVU5EIXgi5CrlyDlCnTpxW2lWKTjmwY/duejSbBA4/xINGF
         cl9p3WvJMPfMA2wH+RIqqUtbNfejKb30vQfU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524538; x=1688116538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/bYqGFJ4VOGoB5+32Mcq8JR70Vd1T1ITCSeV7/3ifk=;
        b=G1UYRdfqoBRO8/lpo/srLuEGFAD9I5OS677VUPTVHbKu8vb5LZeD0TmUa6dwdD4TOv
         WK2F2BOoNM8SbSdVyLrJBNIM6zMIxxNTBQkGy6ZQyZ6QAeISYqNm/rtBi/2sYYC4ibMl
         2aRsKZz+M4Tyfp8kkIA9e3WaW4eN+FW/GsYwGZXiuknen3cfIkstIW2/LG951IkCo/vH
         9hQcywoLqEP3b/BDN2yFXRT2xA4KR99yZrsvzRZvy6ostGAqfyww+N1tR3qzihtQGA6e
         yy6iRVHUd6rgoen2/8G9R6o9CPNOk1BxOykZihOAWonnY+xZbHBRyoRRKgjaNfdczCz1
         C/XQ==
X-Gm-Message-State: AC+VfDz3UtFFqmlkReUzcSrobx/4AkdxREFMNLMkQnfzTg0ZLvWJNq/4
        M1oGCA+20NbAAdn1zCRN7FG9ARiaMYn81JuFvBKETg==
X-Google-Smtp-Source: ACHHUZ4+FWciM8qyJY0wuGopESAGDBSeuypok3sj/I3YbiV8yhFjyVDeVyjcnaAR9QRVCUk4jCbe3rFAcVDPPt68Cvo=
X-Received: by 2002:a17:906:9756:b0:967:21:5887 with SMTP id
 o22-20020a170906975600b0096700215887mr4163471ejy.40.1685524538465; Wed, 31
 May 2023 02:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230531075026.480237-1-hch@lst.de> <20230531075026.480237-10-hch@lst.de>
In-Reply-To: <20230531075026.480237-10-hch@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 May 2023 11:15:27 +0200
Message-ID: <CAJfpegtPM_=3uGdxxkb9xP8LVg5P0Lm-w4TNLYhw+MqcNi8c1g@mail.gmail.com>
Subject: Re: [PATCH 09/12] fs: factor out a direct_write_fallback helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 31 May 2023 at 09:50, Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper dealing with handling the syncing of a buffered write fallback
> for direct I/O.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
