Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80D85B1770
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIHIpQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIHIpP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:45:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF19E697
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:45:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so16038465pgb.13
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NYu0YovWqWzWdfYZiJVYYZmwb8uVVf1jRoDTIyfDYvM=;
        b=h8FBDpFFcNgXkreE8ybyjncZ1bCovumHhd2b49wwwvlj/0es3mwhQErjKfjw+kbNmC
         5queqTF+nKn4D0pLchqbP97y6WmtzbIeU2i1QrpUgsL2833O7s3a8UP+kaXvKnbcK9wd
         iuVRoUNoFDrBeeqyEke5/QRmEzinsRRD+7V+MlHwCRbZUm1IHJtxSXl4dqNVE7aW3eXv
         FbA5sI5atywqsqltPJLX5a4XCy1lClElFsYUp/k4FIWNsK7BoVvUwMwrPvQKLdOUzrqh
         gtykmUCF9CV6QR/IIaRguxevPpU+hc+aDNhxw8jAzlDRUFlagR/Di7OVLBP6NmZHs9qB
         4OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NYu0YovWqWzWdfYZiJVYYZmwb8uVVf1jRoDTIyfDYvM=;
        b=Yq0osPzbT0RtsX66s5KiTyinnk8L1lzvKp0XrgP9YjaToka+icBg1gPYNYTK4SXgp9
         Pr9p6g9u589FhYzFIAzvHgAbJOfrvFOIFAO2Ea61jKuIt8piNtiXMJ3q2dsE2IDNOgpS
         +rj0DWnLwQ2mAjrFoGrISeI+rfZm/rOv3fTpJw1KNkKWx+OvM5mPklYTaOM7fmRbLprb
         +NiQxb2RmppV4EsmqEkE1BYHV9E1FlvCAyf7SikQCRIp3e1pdHehoTcdynXaEYBqx6Pg
         BDQ/c6LE/s1liJOQWpgEPc7VH+DihCj8EqWPsd487H1aLKJYEtKdpAUZdB44ZlO0qz8n
         7zHA==
X-Gm-Message-State: ACgBeo0itNDahgzi2BtCmRymJNPz6OHL1Ganyom2AJgMYmLBgCh24Q61
        j7IbdjuEsSd7ms1C9Ponp/I=
X-Google-Smtp-Source: AA6agR45KAWFum17/6Og9/bc+5DZyWC8JX7WLNVyuFHuT/n9OZ0zwugoyda8OYI7jCnpnD9qrUli8g==
X-Received: by 2002:a65:464a:0:b0:434:883:ea21 with SMTP id k10-20020a65464a000000b004340883ea21mr7312550pgr.152.1662626712644;
        Thu, 08 Sep 2022 01:45:12 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902759200b0016c50179b1esm13795329pll.152.2022.09.08.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:45:12 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:15:07 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 04/13] ext4: factor out ext4_handle_clustersize()
Message-ID: <20220908084507.s2wyb4gznl2vmll2@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-5-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-5-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> Factor out ext4_handle_clustersize(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 110 +++++++++++++++++++++++++++---------------------
>  1 file changed, 61 insertions(+), 49 deletions(-)

Changes looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
