Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBC6FB666
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEHSq5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHSq5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 14:46:57 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3255BD
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 11:46:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3318961b385so49657945ab.1
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683571615; x=1686163615;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=cA3bVL2j4rzAZFiY/YzhdP+MWqU7Vx60vhdmqBsVi2SA07xCwlqNScnOTrvVrFCgO1
         dtt6BuN0BZ45Wo1EX55xFV2qifJMtlosXdCUBRbLrlaZY/D63TvfL06aytiKj2VvT7dM
         12DBzaXez/Q79cfvBz/ur5KbgCBs9ZhSHV5ojoyvOLAVxQQ4aOJ9BuW+DKj4jh2xPVK1
         f48HH2dVBjncRAZi4YpRSm8hBGwD9dfVZVnPVOsH5NnO8kUvIEq3vbVUJFlBKER8r7+2
         Kem0VI0fI0Dt1dWdyaPE0XmotZqmgG667lp1zC0UVzB68L2ctvDxfNfUe7j0AuK+elSe
         JlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683571615; x=1686163615;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=DTN0eKJG1lHq911vwfpFH5Bkr9xLTo6LcS9uHnyzx6BYI0vut9lDgVpEVDMJZ8xdsR
         L2vNqe9OW4wxXIvvKZTtyvru7r3FaHGzadsGfWhRVZU1dlUmU4Rq+rHvW8JqSHGcTWJV
         vBOHEjWO3La6aUuvLMAgeRo6iuszs1B9jYShQIclI1bEW76I7XtJGPBD7ebqfWTO+2Qb
         xmpgm1aBqLio6imVQQFPCKOnwUvtPDF2Px7tRGEV/k5lU2cgZjj6cWQr7/60ty0gw8Wb
         Eh/1VIRfdFTH4wXmdwzAbopVNAPoRnwDtNe7gNWVE1aBn25kG72Vixd6gkmi1Q0g9vux
         894g==
X-Gm-Message-State: AC+VfDw9brS6i781REDCl+YSrsqvTCXHLCEQd3CCyFlKC7KuwWQgo0UT
        yHoiXSfWlibH3OreV+vLS143on5A74NF8DUQKnk=
X-Google-Smtp-Source: ACHHUZ6Cll2NrkYZNpuEn2CmrxU+feAe1ZcJ2crcvpk6u7iDii0s3UJYCxYH1tnUE+zILtlWjOdpsTmqeODPdX8ZKh4=
X-Received: by 2002:a92:c26a:0:b0:326:1d7e:1238 with SMTP id
 h10-20020a92c26a000000b003261d7e1238mr8664772ild.16.1683571615402; Mon, 08
 May 2023 11:46:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:388e:b0:40b:d56c:9d97 with HTTP; Mon, 8 May 2023
 11:46:55 -0700 (PDT)
Reply-To: pmichae7707@gmail.com
From:   paul michael <paulmichael7787@gmail.com>
Date:   Mon, 8 May 2023 19:46:55 +0100
Message-ID: <CAHMLK-xFAoZHpqUfCxKsySXuzzRDXGVxGiK2-EskcB0pTJk_wg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Every time I retest your email, it tells me to check with my ISP or
Log onto incoming mail server (POP3): Your e-mail server rejected .
Kindly verify if your email is still valid for us to talk.
