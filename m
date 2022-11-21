Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC9632E95
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 22:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKUVPv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 16:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKUVPv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 16:15:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE81B7A6
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 13:15:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b11so11526368pjp.2
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 13:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nw4280vwj2f5WYqCk4Z9/IndXBzQTPRCYcKzRb1bHo=;
        b=J9AY8sOSW9URgz0YQ4nOO6U3ssnHWbY+4/68DOneQuYcch3UIq41LcxOITzcNQzwwI
         YnCCo5og55kuPL2EnU4q9uoD64YkJnTT/P8rhHXCMaVDhzMQcYxLTBEKn1zCyZpP41VR
         wcF7KKny/EME8YU0i1BVoeuPpuoAZ8w/huK3brrvJ0fqpdcSJK7O/10m1+CjcoKhPUkS
         tBA0pbQGkjmw+wzaZlf9ecKVZobB/JFtyD2jVCtVnNihpoeRz6BvB7m7Q93i+69UI/m4
         0vqPW3gCh1xRR2wafX722yipnlvQ+kHKf+5hPrN90hhaKLJQ0KSjsAaxRiRHlBYPthPi
         G67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nw4280vwj2f5WYqCk4Z9/IndXBzQTPRCYcKzRb1bHo=;
        b=rMUnWInLQnHuP9niJkHJm9r1Hzk81QGUGyO/Z0Kv9Aodlb+uR1Gr1eh7vnja3EKGTr
         RvaqNZCdu0e+XCkd3ABkFvzJ94xVy9JXY+99S38pUxDnZW+fVoONQ/Jy3kA6OU1wsLhE
         VGKhk/1TZcSTcXxKWAGp3lR5XT1PmNRNkKebOripQnrOzeoDJS7ebbKsgxfklZZcxXH6
         VkCtGykbYHlytVJlgj3P4bGGTVhxveUrZOpZwGWnSFzV67ye1m1tJtM50qj8QtPbYvFR
         1GKBY9oPpEQlNzYlcPFDuQ2948O5xrbSuhHSV1BhjJXzB0KjPtOHL+lRkvP7NlOL0YQh
         HhPg==
X-Gm-Message-State: ANoB5pkVBgv3bRwsNui6XXGqw5ocUcJVxmqv5JvMRds0mNvp0YETahlu
        TaMi0t8al7wTIho1z9EK0Ywu7w==
X-Google-Smtp-Source: AA0mqf7E/nc7BcX4N50O3DeqvCS9Nfp1Edi+XWz4GgiEO2WcY8Fg9tsiCWXe2OnKngBWi/aeehq8mA==
X-Received: by 2002:a17:902:b78b:b0:186:e2c3:91c6 with SMTP id e11-20020a170902b78b00b00186e2c391c6mr1018137pls.27.1669065350224;
        Mon, 21 Nov 2022 13:15:50 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709027b8100b00181e55d02dcsm10283918pll.139.2022.11.21.13.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 13:15:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oxE8p-00H11n-9F; Tue, 22 Nov 2022 08:15:47 +1100
Date:   Tue, 22 Nov 2022 08:15:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Catherine Hoang <catherine.hoang@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 0/2] porting the GETFSUUID ioctl to xfs
Message-ID: <20221121211547.GL3600936@dread.disaster.area>
References: <20221118211408.72796-1-catherine.hoang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118211408.72796-1-catherine.hoang@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 18, 2022 at 01:14:06PM -0800, Catherine Hoang wrote:
> Hi all,
> 
> This patch aims to hoist the ext4 get/set ioctls to the VFS so we have a
> common interface for tools such as coreutils. The second patch adds support
> for FS_IOC_GETFSUUID in xfs (with FS_IOC_SETFSUUID planned for future patches).

FWIW, the next version needs to be cc'd to
linux-fsdevel@vger.kernel.org because we're talking about lifting an
ioctl to the VFS layer...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
