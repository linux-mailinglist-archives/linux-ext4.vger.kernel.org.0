Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A392E7C8CC0
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Oct 2023 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJMSEG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Oct 2023 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMSEF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Oct 2023 14:04:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47056C0;
        Fri, 13 Oct 2023 11:04:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c8a1541232so20947615ad.0;
        Fri, 13 Oct 2023 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697220241; x=1697825041; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sfjXdT7cAyc2iDE1Sn8k9xOdZrrZkWk2OCvv9E04Z4I=;
        b=QdaF/6QwyBMIGP6nyfhSjJc3kMeaVFN71Yq65vWsCx69+5GFfPe0j+j8nqEhKj5LMS
         oFBoRQkQAdhnWw3xHoNHke8hRmEpAlUgcjUoaQarCuQ9L4oX6rl9OttBroqNhAbKaXc4
         aBdVeNobDhliH2L3DxR87Zlwz3n5SMmPmgEpNywKbV5gWzXYfDSdAppsLX8eZYOju3/B
         QLotmfJwt0okb+xrDInJVE+TXSu2N7BVxgySqsKafnZit/81tbJLEBj3fU0yJVbsiRSV
         BVulcVusii0Svg+ogT1fvSxx8TKXoHEOzUybIAzMbNi/hCBijfh8BBFpMjS1XkLycLal
         B4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697220241; x=1697825041;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfjXdT7cAyc2iDE1Sn8k9xOdZrrZkWk2OCvv9E04Z4I=;
        b=neuizUH+b+KRCbadZlRMZ1xDOkPBz/hxPRnU5G7NXzgkcr374L6qWJEoAFS/NBq8Ww
         kf4aJoVWSIlfrSI/zzVYyteMScLoma2Yg0X9VQlRUkeKcQs143SPPHiqsHDVxYr7wpqZ
         BnOMePmdBYonEOY+NIDL2By6J2oRzsU5tDReGFHfyc0yU3L1UOi14FfjmhGBxHW3/964
         182hSSrPnDYRPlWGOSmnD9rIrkfdjkGjtNwXEu+JdM28skV3hv9yrvLdMyPNsm54mFze
         MgKbMge2gB0E8zngylMIXRwKdgvp0qsxEV5NGY8HIKFgnu8NdOl/6BI3ryVecvvk+6Yx
         nV8Q==
X-Gm-Message-State: AOJu0Yz6lnng1SSkuFVHQbPE8dYhk3Ya0kjU3jl4GboPFNf1eiw0SGsE
        jhH4LeeNPlM8z6xDL/B4R9XxKwV5IjY=
X-Google-Smtp-Source: AGHT+IG4hjayqt7WDglsYpaApzyj0EmlG83LNFBeImgkYu1e6HfmQ5q+4CxIZI7DGH/fT65n3lJp7Q==
X-Received: by 2002:a17:902:f688:b0:1c9:e830:160d with SMTP id l8-20020a170902f68800b001c9e830160dmr4544137plg.22.1697220241158;
        Fri, 13 Oct 2023 11:04:01 -0700 (PDT)
Received: from dw-tp ([2401:4900:1cc4:c403:d76d:9a77:e4fd:36be])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001b9da8b4eb7sm4170044pld.35.2023.10.13.11.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 11:04:00 -0700 (PDT)
Date:   Fri, 13 Oct 2023 23:33:56 +0530
Message-Id: <87edhyielv.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Properly sync file size update after O_SYNC direct IO
In-Reply-To: <20231013121350.26872-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> sync file size update and thus if we crash at unfortunate moment, the
> file can have smaller size although O_SYNC IO has reported successful
> completion. The problem happens because update of on-disk inode size is
> handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> dio_complete() in particular) has returned and generic_file_sync() gets
> called by dio_complete(). Fix the problem by handling on-disk inode size
> update directly in our ->end_io completion handler.
>
> References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> CC: stable@vger.kernel.org
> Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/file.c | 153 +++++++++++++++++++++----------------------------
>  1 file changed, 65 insertions(+), 88 deletions(-)
>
> Changes since v2:
> * Added more comments explaining the code flow
> * Added WARN_ON_ONCE to verify extending IO is handled synchronously
>
> Changes since v1:
> * Rebased on top of Linus' tree (instead of a tree with iomap cleanup)
> * Made ext4_dio_write_end_io() always return number of written bytes on
>   success for consistency

Thanks for addressing it. It's always better to have a consistent return
value wherever possible.

> * Added Fixes tag

Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
