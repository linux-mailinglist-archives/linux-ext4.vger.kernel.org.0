Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6D6330A9
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Nov 2022 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiKUXUP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 18:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKUXUO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 18:20:14 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97DFC6628
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 15:20:13 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s196so12550283pgs.3
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 15:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NPqgSPsoKfJn0uOOPN9O9DTl+jaPUH9m9QVbYbym7I=;
        b=1jqgc7FQCoWCh503no+jq3J2NfLcBFrn37VzcRMQJq5Rob5kTTt9dZ1HqHuSjT+2N+
         +6d+ypSgTLCEbdolZCY217OedVM1heZT3eXmYoLL2ACwTPFguTQjv+enl0WFOiyLXxjK
         sNTK/yY1u7BexvvokD2a/bYm5Jy9pTKUU7oQjJPQmHiTzxZdKZi3W956NauctvdfIwNP
         PV8VG9PCvsMBmkGHrncb6VhJbYO5PlxHIizuYtTY91jnoMYWmTp1XTAhjkx5lVnqU8F4
         /jSd5hqg1lpM9dKgrwMU80uZYS3Uk7XsJUYPPQi5Qtf8l6pmCWWCWNY5z3rDOKc2Hw1Q
         Pupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NPqgSPsoKfJn0uOOPN9O9DTl+jaPUH9m9QVbYbym7I=;
        b=RSSKQKQGBD01DUCf6LoYUM2n7oMKYnlih7IdPG+vRuhXW14XTOHouwlZCgP6Z0c7tF
         ZJx2b8lPdWgplCXtTr48prlYBnbjDDGFXDVg/UZBpPE9NfcQTZEEQf+qSn4r2ZmB2BBu
         tTg4ZwSp+0GAMB3LFNFL8FlKTis7CwTUiTEg4Hf8shLhDsK6FKd+ZJp8ysctjt3ivxmX
         ZPfS7b8hAulhucYkmTjxoH0+daL6S+lXg+bTbYkR2yzOO8/kAQDJzSeYx9N5CcZg8UTt
         8sxDHRXzw+0ldgVhDISUxt/yhDSir8JsQDDCdbq3RnylRMGdqeNXLFqm4tu2kgkMpe8d
         s2/A==
X-Gm-Message-State: ANoB5pmfGXj5mjtJeoP0vfrGK8xCBKYdZh9WLduRSV+W9vrMkPByhfQX
        5RJBzY8w9c1S41Pm3i5PdAJ7tg==
X-Google-Smtp-Source: AA0mqf7LMkIfQKv4SC3GcQLKgPvqW0OwxFVBW3mo/TbATmM4hW9OdQVb8Hh9NW8h2/2pBPmJofUS9Q==
X-Received: by 2002:a65:6049:0:b0:477:2ac1:9d2c with SMTP id a9-20020a656049000000b004772ac19d2cmr951198pgp.184.1669072813390;
        Mon, 21 Nov 2022 15:20:13 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id k186-20020a6324c3000000b0046fd180640asm8043926pgk.24.2022.11.21.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:20:12 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oxG5C-00H36z-59; Tue, 22 Nov 2022 10:20:10 +1100
Date:   Tue, 22 Nov 2022 10:20:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: add FS_IOC_GETFSUUID ioctl
Message-ID: <20221121232010.GN3600936@dread.disaster.area>
References: <20221118211408.72796-1-catherine.hoang@oracle.com>
 <20221118211408.72796-3-catherine.hoang@oracle.com>
 <20221121210223.GJ3600936@dread.disaster.area>
 <Y3v5R+FlFf5KvLsb@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3v5R+FlFf5KvLsb@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 21, 2022 at 02:18:47PM -0800, Darrick J. Wong wrote:
> On Tue, Nov 22, 2022 at 08:02:23AM +1100, Dave Chinner wrote:
> > On Fri, Nov 18, 2022 at 01:14:08PM -0800, Catherine Hoang wrote:
> > i.e.
> > 	if (fsuuid.fsu_flags != 0)
> > 		return -EINVAL;
> > 
> > 	error = xfs_fs_get_uuid(&mp->m_sb, uuid, &fsuuid.fsu_len, NULL);
> > 	if (error)
> > 		return -EINVAL;
> > 
> > Also, uuid_copy()?
> 
> Why does xfs_fs_get_uuid use memcpy then?  Did the compiler reject the
> u8* -> uuid_t * type conversion?

No idea, I've completely forgotten about the reasons for the code
being written that way.

These days people seem to care about making the compiler do all the
type checking and type conversions for us. The use of UUIDs and
various types within XFS has been quite ad hoc, so I'm just
suggesting that we improve it somewhat.

Using types and APIs that mean we don't have to code the length of
UUIDs everywhere seems like a Good Idea for newly written code...

> Alternately there's export_uuid().

But we don't need that if we use uuid_t for all the local
representations of the UUID....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
