Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53EB69F36D
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Feb 2023 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBVLZ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Feb 2023 06:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjBVLZ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Feb 2023 06:25:28 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CB34C15
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 03:25:27 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ks17so8105582qvb.6
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 03:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vOrHtOVLGykpzNoSTdturIO6iNH22xcWXLn58cgs8nA=;
        b=Ohl1SUmt7ZqAGkSwM1VYhDJTLDaUi56ZMkdu5gph/wQm4D6l8GT0a6V1tPwkfQR1ud
         Uapj+DKyvFDDuZhlKigmbazlme1ueMJdDf0U3sJT43i6tj59ZyZBGcPfWcQ5fgxY1Oiw
         M37noVmcD45r0VXWz5KXlXPOLD2KeHhRdK4fyRSzzjV7vZNCUau63x0VLEHf04e8Vi2N
         kzUL5bGRs8lht4/AoXXvUF+vJdpqmYjOxPTK8SlndJRxfEEzbPVwCSXGBM1wXyFEjwAy
         grjya3/lojK9EfjGZIW0VSgBSt0BIHR67hNs5Ug7kmGqWMBbxVr53FaKWDvnT0sQ7xsn
         yDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOrHtOVLGykpzNoSTdturIO6iNH22xcWXLn58cgs8nA=;
        b=foK4VFKb6S+7zDSzwklncgizJOEuofz+pXkTRMhr/B3RZNNs6sdjSjDgt2NYH+lsoj
         FhiPMtAR+Xd8pBgBek13Osgp/LqdhbqvHGh2wkH7bsaI58sQ5CFlmHt2EC9At4MPeXBh
         upgcseq+j1cL0cCYq6BAGCGgOns9hnFLjNMTEjzyUBtkQtnL5Zmp/Aby00AR+apfR3b5
         GfwODny1vdPNpQpYs0/GNk95BtduyfuRhE0pNJRu/HZXE/OY8tEO0kFFSDItkQlhBiju
         B/1x8oiNKEwlqt4jVOKsa0RKujBSGgrg0B4sgVWTdwpYlvaIytHXLClHjp7pjrnp077Z
         9+Lg==
X-Gm-Message-State: AO0yUKUuIqoiSPAido1b9pDwcJCO9gbp+Gu60hiAi4Bf1MlyqHRA/wyC
        Aj1x1ZnK79CuH0lOaPQ9WUt+UQxZl4vTyqo5b6s=
X-Google-Smtp-Source: AK7set8yj+udN4k27BWuvRhQw5CI4SZeJ/2VmYAcqpNjLRZplXtgtZVJIyr3GhX3zCjrS+jIoeZSrZ/72Izkj2CHiDc=
X-Received: by 2002:a0c:e24a:0:b0:571:bb7c:3d53 with SMTP id
 x10-20020a0ce24a000000b00571bb7c3d53mr891061qvl.57.1677065126734; Wed, 22 Feb
 2023 03:25:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:12d2:b0:567:f85f:b39b with HTTP; Wed, 22 Feb 2023
 03:25:26 -0800 (PST)
From:   Sky Ventures LTD <everrgreen2016@gmail.com>
Date:   Wed, 22 Feb 2023 11:25:26 +0000
Message-ID: <CAMXdwAr_vJ3hQvWZcOb5d3qhrh0F1TeEkkUi5DexertjYbR+zg@mail.gmail.com>
Subject: INQUIRY
To:     241158141@qq.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Respected Sir/Madam


We are interested in purchasing your product  with delivery to Kuwait.

Kindly respond via email with your most competitive FOB price and
sample photographs.

I'm awaiting your response.

yours faithfully

Mr. Everest Green
Ever Green Sky Ventures LTD
Toronto Canada
Whatsapp: +1 (951) 766-3007
Email: everrgreen2016@gmail.com
