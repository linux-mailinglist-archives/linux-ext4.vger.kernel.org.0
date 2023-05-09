Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15BF6FCBBC
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 18:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjEIQwa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIQw2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 12:52:28 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AA19B3
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 09:51:41 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-75131c2997bso2273266685a.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 May 2023 09:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651101; x=1686243101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AiXugarlhHToBN2ueOGwWaX5E4llz8s13EASoB3wVI=;
        b=KFzB3b17C1WoC0FNNaac6KG/S5ShYzk35IznCDabiVxbf2XjsYkUdd1emhHoM7Hzfs
         afgt6QDLqLjocD5GHpi9ggy56UnXR95a+PI8jx4fYOHw00kysoUsSIOqqjXrbXka7qxM
         F7wiKmSppEcpftU2dGTyhBq3s07oJp32NxkvbPH/NBxbpbkfsD1ObrIt9D7Qj1VDZyNr
         HfhHlQuJ8F4103Ob0dfyEsRYJ3FW/zkTgQDmJtiGDXdmEPLfY9lprx8oJETPBFSTop5s
         eK0HdibVsI3dz+8JOIyIaPFBHZd8+0Duq7W0QpmgliqbApdqhnUWTcKqoxAO/XBt90Io
         0NDA==
X-Gm-Message-State: AC+VfDzgluhZPD+5TK65DdR9WIM7/Y8EGHm/PXyG4uiPrwLJR8LkpDhd
        yj0wQfcSimGN6oZevG/pjFcX
X-Google-Smtp-Source: ACHHUZ4xRyujKImbkSQcW8Z759B/taKjk2/BBWT+4ePbKXa9irKnpFPNPIQc/SyDOhMLc66FmfxRwA==
X-Received: by 2002:a05:6214:29c7:b0:56e:c066:3cd2 with SMTP id gh7-20020a05621429c700b0056ec0663cd2mr19939922qvb.2.1683651100740;
        Tue, 09 May 2023 09:51:40 -0700 (PDT)
Received: from localhost ([217.138.208.150])
        by smtp.gmail.com with ESMTPSA id m4-20020a0cf184000000b0061b3338d6d9sm890247qvl.50.2023.05.09.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:51:40 -0700 (PDT)
Date:   Tue, 9 May 2023 12:51:38 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
Message-ID: <ZFp6GphV3H0eyrH+@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-2-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.
> 
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
> Cc: stable@vger.kernel.org
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
