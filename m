Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634BC617ADA
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Nov 2022 11:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiKCKcr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Nov 2022 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKCKcp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Nov 2022 06:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79640DF31
        for <linux-ext4@vger.kernel.org>; Thu,  3 Nov 2022 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667471513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGLcnmD6PutmTSm1n72zcGIMTXoaJoPq7ziNFejegjw=;
        b=Ymbkg30ufampbMDbAlO11CPFiDdzvSIUWAi2OLFNcLdcy1qq5VSV1ryriniqVaPB/9RDam
        0Skgd+bRAcapvBQjx5SBEsbNOBcNFUF3829W9/xq1w2WDzuWNVWEiHHHWnqO+jGdhJOeHQ
        M8f7sWLWwtd/Pt9DWqmFGKI4OhNMVng=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-LC9J-HzkOfqPjIsjJKrMPg-1; Thu, 03 Nov 2022 06:31:51 -0400
X-MC-Unique: LC9J-HzkOfqPjIsjJKrMPg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F48E3804512;
        Thu,  3 Nov 2022 10:31:51 +0000 (UTC)
Received: from fedora (ovpn-192-135.brq.redhat.com [10.40.192.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E742492B06;
        Thu,  3 Nov 2022 10:31:50 +0000 (UTC)
Date:   Thu, 3 Nov 2022 11:31:48 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: periodic lifetime_write_kbytes updates?
Message-ID: <20221103103148.2r3gcaqpngq6jphg@fedora>
References: <92BC4EEA-69A6-4AE0-ABA8-304E9DE2D4A9@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92BC4EEA-69A6-4AE0-ABA8-304E9DE2D4A9@dilger.ca>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 02, 2022 at 05:41:07PM -0600, Andreas Dilger wrote:
> I was looking at the /sys/fs/ext4/*/lifetime_write_kbytes counters on
> my home server and wondering about how accurate they are.  That is most
> interesting in the case of flash devices, to get a good idea of the
> lifetime writes vs. actual rated drive writes per day.
> 
> It looks like s_kbytes_written is only updated on clean unmount
> via ext4_commit_super->ext4_update_super() and in a few error handling
> codepaths.  This means any in-memory updates are typically lost if the
> server crashes or loses power (which is typical for long-running servers,
> rather than a clean shutdown).
> 
> It would be useful to periodically update the superblock with the current
> value, maybe once an hour if the value has changed more than some small
> margin (to take into account the *previous* update).  The superblock used
> to be written frequently via ->write_super(), but this has not been the
> case since commit v3.5-rc5-19-g4d47603d9703.
> 
> Any thoughts/objections to a periodic task calling ext4_update_super()
> every hour if there have been any noticeable writes since the last time
> it was called?  This could potentially be more clever so that it only
> writes if the disk is not asleep, and do the writes the next time it wakes,
> but I'm not sure how easy/hard that is to detect at the filesystem level.
> 
> Cheers, Andreas
> 
> PS: there is *also* a function resize.c::ext4_update_super() for added
> confusion, but that does something completely different...

Hi Andreas,

I don't have too much to contribute other than to say I think it's a
good idea. Having the counter be more precise and as such more reliable
is a good thing especially with what looks to me like a litte effort
required.

Thanks!
-Lukas

