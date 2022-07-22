Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF457E333
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiGVOqh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOqg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 10:46:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742403CBE7
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 07:46:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q3so2758691qvp.5
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=df4iR7pMvrxYaKY5tkfKrDSnAWquqnp9gigO4m2rw40=;
        b=XDNQVjUobLRovcUE033e8SbR40OHE9d7K0/cTo3xprBzvQTgBY5JRQaHJ8DW9JvpBK
         Du/XVlBki9mwrNDK2KMKGaRmAEJV+pX/BgzceJurmiGbMDIDuiAxrhe6+NwY1GnW3u5Y
         +x4D6uWlGxUHZ+8MoEvTaLscsvg5us1D4PZlXR42Mbh5ChsuYblvwH3BD91hhdW9nDLP
         Ml+2MDl3WSnzXnlWjvBUQY0toWsu4ngIuy+MFF6D/SF5pMElKAXAUSOhDK23WexlrR9z
         QZGphHtNsO043TO2MqoM6m3Rw35al+9+lvCddZLhlqL7PI1DT9DugBGDk0O0YKv3L7W+
         5xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=df4iR7pMvrxYaKY5tkfKrDSnAWquqnp9gigO4m2rw40=;
        b=FQoJyGDP1Y8LuhhKPic00Pu56KtFCIXdySkiRTfKg8nvEBtMlD0uEwlMT2MCieDU2V
         pTPlCoENcF44dPqDUTGwTBwHWaxM/ocdAf16Sgzh1LL83BIlQu8kCRFKIYgyFvGdk02o
         rwIGNqlN8uewzOaEedz3usN/k5MG6rAY/QV1uHntYn7K3jKar2San4krIx1NMG15lzAG
         9zEXBQ1adHRtaDeHmiiZz2lz8tA28mtu92U3romYuAdiYFKMRyGymHda4cYQZXcMFV+f
         dyugczpMGc+1nRrTF5MZhjKg1M6g8Nkpt6X4ztmm3C6390/lNzAuZkJFrcpevFQqfdpQ
         lBQA==
X-Gm-Message-State: AJIora+ly61n9ifk1JZ2W+OFEkJilt0eR19ANaWouTPVMemDjAGI0XID
        5FBdVPENx7+6aHqPKkhXlyQ=
X-Google-Smtp-Source: AGRyM1s99daCjRYDNePiqru6Mbm/OSw2169GenOxmbuVArOYiwR6uicRIkknK1GbRNfrfFUx21qYCQ==
X-Received: by 2002:ad4:5be9:0:b0:473:558e:84b9 with SMTP id k9-20020ad45be9000000b00473558e84b9mr423027qvc.8.1658501194639;
        Fri, 22 Jul 2022 07:46:34 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id n14-20020a05622a040e00b0031b18d29864sm3176041qtx.64.2022.07.22.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 07:46:34 -0700 (PDT)
Date:   Fri, 22 Jul 2022 10:46:32 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Whitney <enwlinux@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: minor defrag code improvements
Message-ID: <Ytq4SDKXE0rqVUVD@debian-BULLSEYE-live-builder-AMD64>
References: <20220621143340.2268087-1-enwlinux@gmail.com>
 <20220714115326.qhjsrchoepnnsffu@quack3>
 <YtcjkMcYQCATlt0Y@debian-BULLSEYE-live-builder-AMD64>
 <YtgbKhYxbX4NPJts@debian-BULLSEYE-live-builder-AMD64>
 <YtoT80bDyqIVuJwT@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtoT80bDyqIVuJwT@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Theodore Ts'o <tytso@mit.edu>:
> On Wed, Jul 20, 2022 at 11:11:38AM -0400, Eric Whitney wrote:
> > > Is ETXTBUSY still reported by the kernel?  I couldn't find it in a search after
> > > reading this:  lwn.net/Articles/866493/
> > > I didn't consider that because an executable wasn't involved - interesting that
> > > it was used for some operations applied to swap files.
> 
> The LWN article is specifically about whether it's worth it to block
> writes to executable files.
> 
> However, if you look at some places where ETXTBSY is returned, such as
> in fs/open.c and fs/read_write.c, it's being returned when there is
> attempt to operate on a swap file using fallocate(2), write(2) or
> copy_file(2).  So I agree with Jan that it's better for the defrag
> code to be consistent those uses of ETXTBSY.
> 
> I'll also add that, "busy" does make some sense as a concept, since if
> you run "swapoff", you can now defrag the file, since it's no longer
> being used as a swap file --- hence, it's no longer busy.  So I don't
> have as visceral reaction to using EBUSY, but given the other ways
> defrag might return EBUSY where it *would* make sense to retry the
> defrag, I agree that changing the error return in the case of an
> attempted defrag of a swap file to ETXTBSY makes sense.
> 
> 						- Ted

Thanks for your review.  I'll modify the patch to return ETXTBSY and repost.

Eric

