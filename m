Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2966307C
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jan 2023 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjAITff (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 14:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbjAITfc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 14:35:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8364A100F
        for <linux-ext4@vger.kernel.org>; Mon,  9 Jan 2023 11:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673292893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CQMDnAlZYFrg+FDGtR42bVuM/yGIczuxLJaq+U0aLyM=;
        b=hbLVHclvn22XGXHqzDfRo4pknyu7gMd/o6TVpXU0sTbbbCfZ4s/+IVvGhj65EmndeOXVA6
        MeA4qcfBAB5CA5+2/q44LosGKlFC1EjRjz8DcbKwlb8XWx0PBHCueYQgIACLb52fzs7K1O
        38nQYKLOExhusZnmdzr5NGrM3l4RHWQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-YORwUCyxNmCiAriZrtDjhQ-1; Mon, 09 Jan 2023 14:34:50 -0500
X-MC-Unique: YORwUCyxNmCiAriZrtDjhQ-1
Received: by mail-ed1-f69.google.com with SMTP id z8-20020a056402274800b0048a31c1746aso5878364edd.0
        for <linux-ext4@vger.kernel.org>; Mon, 09 Jan 2023 11:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQMDnAlZYFrg+FDGtR42bVuM/yGIczuxLJaq+U0aLyM=;
        b=r0oQ/gwH8T/W70Nf8R4ni96a42knpuy48CC5xyI/k0MuHtia1d3hSh900nDuW1W+Eb
         zHOweguaHw1v5Qzkwyh28KHcXHB7NvJEE78UY1dfdTMaZlKThbl5OCBcwAsofPX1WbN3
         2ifSFcI3v2gW6L5yzS/cxB3MRNsFWKw/PqMZzf1NnXKmvOMznvKDn8KTMvMN+1di8cWz
         OjRsN7triCxRS6tt1MQeo4uZnzKGnr2VJYYvnxHEfwm395Q182TlLsfm3SQG/dmTfFdR
         OLO5FHO7Y4fsHusZm5k2UnczKalUQNAaIjCBzT07yj4aeBSle1ku6d5TFvbsaftT9zie
         H6xw==
X-Gm-Message-State: AFqh2kokQRSth46kJx7ZKTm4oE7dCZsLEwBBVOeuO8m+DW3+FjVsb5fQ
        v01uarQNe2Sbv0xMunk99n0eO398AfO3crZEweGwkUCRAdqnjASf4HCNZyVeQlN42T/BwQzqUey
        o674mPk7Xoxn8JtnlKxOM
X-Received: by 2002:a17:907:1759:b0:7ad:d250:b903 with SMTP id lf25-20020a170907175900b007add250b903mr72215585ejc.56.1673292889358;
        Mon, 09 Jan 2023 11:34:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu21stgD+/1EjhJf7J1BgUsBezxrJQMbjX6bK3yWH2CTzDuxtPuKAfnC7i/jdXetHE5M2jNRw==
X-Received: by 2002:a17:907:1759:b0:7ad:d250:b903 with SMTP id lf25-20020a170907175900b007add250b903mr72215575ejc.56.1673292889177;
        Mon, 09 Jan 2023 11:34:49 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm4076001ejh.0.2023.01.09.11.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:34:48 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:34:46 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 00/11] fsverity: support for non-4K pages
Message-ID: <20230109193446.mpmbodoctaddovpv@aalbersh.remote.csb>
References: <20221223203638.41293-1-ebiggers@kernel.org>
 <Y7xRIZfla92yzK9N@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xRIZfla92yzK9N@sol.localdomain>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 09, 2023 at 09:38:41AM -0800, Eric Biggers wrote:
> On Fri, Dec 23, 2022 at 12:36:27PM -0800, Eric Biggers wrote:
> > [This patchset applies to mainline + some fsverity cleanups I sent out
> >  recently.  You can get everything from tag "fsverity-non4k-v2" of
> >  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git ]
> 
> I've applied this patchset for 6.3, but I'd still greatly appreciate reviews and
> acks, especially on the last 4 patches, which touch files outside fs/verity/.
> 
> (I applied it to
> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git/log/?h=fsverity for now,
> but there might be a new git repo soon, as is being discussed elsewhere.)
> 
> - Eric
> 

The fs/verity patches look good to me, I've checked them but forgot
to send RVB :( Haven't tested them yet though

Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

