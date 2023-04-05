Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A636D82E7
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjDEQFZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbjDEQFT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 12:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB34ECD
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ezrY1MpbuGn54W85nscQkQabj0tChDh4QyAKrhiN160=;
        b=SQgvVujUVS8yShHRAXEDNyZ6/QRDvftsI4cxEh8ip96jq0xK60BYMoBf+0/EUOhTXIis+V
        xa2YlDalWCN3GKlPZ4a5QImKgAdeLOGrJ5gi0C5M2BFDG61ZpZGx1wc39t7X72PLjpHsw/
        t7y3LMZvHzSdNfFcursqVJ60AoMOmpU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Z2zeaHukNmqB6NaBC7OQGw-1; Wed, 05 Apr 2023 12:04:21 -0400
X-MC-Unique: Z2zeaHukNmqB6NaBC7OQGw-1
Received: by mail-qt1-f198.google.com with SMTP id b11-20020ac87fcb000000b003e37d72d532so24598347qtk.18
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 09:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezrY1MpbuGn54W85nscQkQabj0tChDh4QyAKrhiN160=;
        b=hZP9emT7LjvJhfk3N9rd4z8WytbsBd2bH1fhFo2/31P2r7ylfAsCdfEO/Yj4BwjTDU
         q3ltV+YbMCPC3qt2eGBlPrFkNwmyV73e6uD48ZFGTgjADb8pvxRMujH2KfKyrsGJZVI3
         BSfrtyg4BeguqTK/ju3poiBrOMwSbTh9vuHP6XBb5TPmQKhB3wUvLwwsoDoGQKalqjJl
         OuShzYg2Hc6EYN940QyH3Xj+AOJkN4ClAbfDufCIZOFA/ga9uFFi02WxA7ooeC96+L52
         /UuTZc/IRIhzPclFujNXjeqyTY+qStJg5/qhbsMLfNmegSTiUOPmMl+mvsfOgBy3YP8J
         avpg==
X-Gm-Message-State: AAQBX9cv6SJ+IyVhsCCSaH6HYFgSJTroze56Jk0lGy8bF4FcJE2yKcAP
        WxBkLXM4mMYaHpGXqqhJMReZhIRRJsuincdAN2uDwPUtgseO46/gobi9oEPlpFGcC7ULcY+BG9E
        fy21Fw8tYDJTL68MG5AR8Ot8vdbkURY0=
X-Received: by 2002:a05:622a:4b:b0:3d8:8d4b:c7cc with SMTP id y11-20020a05622a004b00b003d88d4bc7ccmr7038033qtw.46.1680710659548;
        Wed, 05 Apr 2023 09:04:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350a5lKksulKGDz1s6x8IlpR6R6JUlCw8aCDbcTRwKrjAxeI/G0vqKKfr43MPgy1YnBz9zPAfFA==
X-Received: by 2002:a05:622a:4b:b0:3d8:8d4b:c7cc with SMTP id y11-20020a05622a004b00b003d88d4bc7ccmr7037982qtw.46.1680710659193;
        Wed, 05 Apr 2023 09:04:19 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id b9-20020ac84f09000000b003e398d00fabsm4083588qte.85.2023.04.05.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:04:18 -0700 (PDT)
Date:   Wed, 5 Apr 2023 18:04:13 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     djwong@kernel.org, dchinner@redhat.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230405160413.7o7tljszm56e73a6@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404233713.GF1893@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404233713.GF1893@sol.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 04, 2023 at 04:37:13PM -0700, Eric Biggers wrote:
> On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> > The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> > xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.
> 
> Just to double check, did you verify that the tests in the "verity" group are
> running, and were not skipped?

Yes, the linked xfstests in cover-letter has patch enabling xfs
(xfsprogs also needed).
> 
> - Eric
> 

-- 
- Andrey

