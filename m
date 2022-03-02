Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489914CAD8E
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Mar 2022 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbiCBS3y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Mar 2022 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiCBS3x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Mar 2022 13:29:53 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D69C7E40
        for <linux-ext4@vger.kernel.org>; Wed,  2 Mar 2022 10:29:09 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2dc0364d2ceso28346477b3.7
        for <linux-ext4@vger.kernel.org>; Wed, 02 Mar 2022 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=43J0yXvH4ROwR66NzzY2ROnhEkvw7zmvsdv9tyaOFBg=;
        b=A2RlgR7KpOS+cpKyjYU4I762WvjwiX59aniOwU/l5tJAEduCBWsXKmclf+n3R+HiPa
         0/K/oHLumm7DMUvJhEU7Q6iJD4IMo/8bcYqiZbsWPdyilXIVjwkQJPCyQx60EzD89uUV
         xObAdoUmFZW66Bg00ZsAprQMGnljal7YYa/7Q+9nSPW/FRZ0VuzGOddJKOiVTtEx6mC+
         1VG4WaN+8YtGAlleM8Y5OQUT8RoMzG5fq3Zz5eu8vwsu3/W3KcE54auWSQmOzQeZ/1ND
         rKVNUpAEEdus6KtS9BvZA2B04sTg9Y4xn0NMikDtsNDRSQiE5jv/r9OLPcwzLqZoOZua
         pykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=43J0yXvH4ROwR66NzzY2ROnhEkvw7zmvsdv9tyaOFBg=;
        b=arODve1DfV56w12g7cQZq+9q0mpUFcSExopwPk8ZSlqg/EkU4Wm38Cu1iehAcKMQN2
         Ogjl2KHWi4a83XIQjqNP+6ME0aHgRQp8zyj7kBWORiV2y3c3fDW5S7W0HTPK2ATe9lML
         g631bbrdakvNiNyojusyhXMB0TiZm/82ZoKI16Rytzr77+IdLxG8VsioMTd4cmtA/npl
         NVx3bSIt0UqYPZb8wEXCjFjwlWmbqVfyArGnO/MlbhzfbNkdiaDaaQsU1hJJtbicQbRW
         8d2+e9Nm2ynCmTSokWmI/HB/koy7bjHCUL2E0ylNIMXXfkz3oRMT6YRSgcgj9sKSoo5Q
         WeHQ==
X-Gm-Message-State: AOAM533BJsER4PQhgEXmnf4QTuLYsJ7BcU1/4KnU5+7QDCJH4ReJORzw
        VZ49KC03gmvGeesyCuEGiSS02lpca4DE4djBvyo=
X-Google-Smtp-Source: ABdhPJxJksYRugGZHkGe/0PCCMvjbfevPppEsrugNPnEkDdHKWzbCOTY05ZWIQBnrBrdKW5G2aqwjL+Fh5yT1gEX5tw=
X-Received: by 2002:a0d:f543:0:b0:2db:5966:f27f with SMTP id
 e64-20020a0df543000000b002db5966f27fmr19545246ywf.473.1646245748907; Wed, 02
 Mar 2022 10:29:08 -0800 (PST)
MIME-Version: 1.0
Sender: agbevecatherine1@gmail.com
Received: by 2002:a05:7108:6308:0:0:0:0 with HTTP; Wed, 2 Mar 2022 10:29:08
 -0800 (PST)
From:   John Kumor <a4779799@gmail.com>
Date:   Wed, 2 Mar 2022 18:29:08 +0000
X-Google-Sender-Auth: nhEj5d03r0ssgduiGie_SYuNf88
Message-ID: <CAFW84rPDFcwGW7kvLm5y2cRJex7gzY6oUaNq3KWZ+m37FfVOWw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

My dear,
Greetings! I trust that all is well with you and your family. Did you
receive my previous email?
Regards
Attorney John,
