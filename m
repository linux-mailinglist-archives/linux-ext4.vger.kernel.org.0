Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548251DDAD
	for <lists+linux-ext4@lfdr.de>; Fri,  6 May 2022 18:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348898AbiEFQjW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 May 2022 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbiEFQjU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 May 2022 12:39:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B791FA78
        for <linux-ext4@vger.kernel.org>; Fri,  6 May 2022 09:35:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq17so15489786ejb.4
        for <linux-ext4@vger.kernel.org>; Fri, 06 May 2022 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=LFySC90bJuXn+ixuF7OKi7SgGN8QEKuJyLc/bPTHKIB0Akv6m8aymm6nfea4sHd7p6
         NW7DkQSFxe6nFjXSdZYvYDJuk1oBS9pMf+AtZoREWIICx4aNOLZBp25F/yzJO6nkPkfe
         SUjU8nqbqlr2ZzSKFw9534FXC+sJ6KCyfPMymL4NY+EDsaLRaYiTR91EnrugMc8rbsiM
         qCXVC3DFxwQGAtau21uLXs9tROg6iWGC4m7rQzDGFYrzcXSEf065viReh1+j1tzfYc0+
         K/FCnVUbKuvVkECitZTRq+XmOG1f/TjXohc+6ydOMArTxACsldx1TZeH1V1XrJYS3zsj
         zA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=GfzEq0i5QToybPLY+iB3ap8vDehwAUEiycZvixx6wZLDlx0LK7TLBpS8/B7Sz53xRA
         jtqC3QTkJtWWhoStzEnPYdROokFjTnoIdsn0yE7fbGGKV5PwFJxcmCtNk/GIVHGsxR5Y
         SF2atm3nBkc4F80Wgc6IGHNTLJlPwdAgHllAfQSMa8ICgrvMM9hPwqiiquRQ4CT6tIuP
         2+fbedBtBF1K4bgHsiWLYNSqmwcQ4p9cFKVNyDnk9TY4v74GIc+8G/YKS8R7nFtdt7T2
         8IUl5T85yGHCPcLq2QNBNKiVy6v4H+uN9lz61ARCWonLqRKiM6ObTp/cMzDNAHKdUqqI
         AEXw==
X-Gm-Message-State: AOAM533Kim8PgPTHpJHFtNtnrt/uyWsdmHPbr4qXJBBbacYPwXrI+fsR
        VPmdGpIxdcuXZCJqkk6rewGl1RQFXQ8G7o2llQo=
X-Google-Smtp-Source: ABdhPJzls35w4kEoqSnSX6FwS72EEXv1A9gtZSo9FnXPDIy/sK7gG56EaNizpj0fxEcynifwhoBVIENroVC4NIcgafw=
X-Received: by 2002:a17:906:9b89:b0:6da:ac6b:e785 with SMTP id
 dd9-20020a1709069b8900b006daac6be785mr3726619ejc.295.1651854935013; Fri, 06
 May 2022 09:35:35 -0700 (PDT)
MIME-Version: 1.0
Sender: amoudiatchakoura@gmail.com
Received: by 2002:ab4:a56a:0:0:0:0:0 with HTTP; Fri, 6 May 2022 09:35:34 -0700 (PDT)
From:   "Capt.Sherri" <sherrigallagher409@gmail.com>
Date:   Fri, 6 May 2022 16:35:34 +0000
X-Google-Sender-Auth: Wj59QUHXbIs-YVy3gonWBUMcc68
Message-ID: <CAGZPmGH09X+9M+wn3tzzN8CskwmoMnYeyWRBmd21e6BDKZay8w@mail.gmail.com>
Subject: =?UTF-8?B?5Zue5aSN77ya5L2g5aW95Lqy54ix55qE?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
