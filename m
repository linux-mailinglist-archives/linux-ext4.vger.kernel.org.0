Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD816A2454
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Feb 2023 23:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBXWgd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Feb 2023 17:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXWgc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Feb 2023 17:36:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9401B2EC
        for <linux-ext4@vger.kernel.org>; Fri, 24 Feb 2023 14:36:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53700262a47so12973527b3.4
        for <linux-ext4@vger.kernel.org>; Fri, 24 Feb 2023 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcPGn+M6rIqx4tq8u4y5PnmVvUlM4XopORLae9pnp88=;
        b=QOKHFuzxD9Oty0a5Re3OcanrsUmjZ7YVrnvH6W2tuNQqBHXx+lQ3dG9qCPTRT0a+KN
         muI7pzifbe+Ya0/9S758YpqEubAIaILij0y/Yq6KSLuehY72U9iN2uC5eww/27YnHOwm
         7tT20/kgLULJFJO8cQqXDbuebovMxSKrMRNPoA1xisQygA71xz3/LuNX0FqUVFYi5sPl
         xTalxKiPHjmh+Le2ki3dJpFRoW8fewbUcfT4XSY/Iez8ee8FfAehpbz/raDXqdiTXAos
         YLdFzMOIW6Ir9rLt6BX0gsge+6jtZ75hVk3ZZEQ5IRZtYCw1ZRwcYo+1GdGCQ/t8rBcR
         VW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcPGn+M6rIqx4tq8u4y5PnmVvUlM4XopORLae9pnp88=;
        b=qDKKTkZsVixABdysNNfUOzN0XpYEbZZA/8uen2Qds6Pz3DADb+TJJ+tBJ1WxNL8EIy
         nI6HA0Y9L9Ks60/XyA+7ZTvVpurtPvD7WDLFhMTTi73g8NNohmAGDRdfZRS4aB8IU1rn
         E5DV5y1h4Pg1LoIszbK2479DoR1FPeRtubiOJMhMnR9+V8z9JCbks2JmWW48BljUUDz/
         txs9RTnRhvVYOomHM0gvqx6TO/sb87klUmSN/MBY1IqhowvCsNHRqnqGQNNGFV/9yMSB
         +Bwun14jx4fJyJ8ehC86C1M5kwx5rRQ9UmQ5/z1Bvw2/qM3bPLw1eOrhEPyBCEdda5AQ
         peaA==
X-Gm-Message-State: AO0yUKWEAeOagdkVwoGD4T88+5GFnLp7v8Vl9qw4YG8nDwZNaoncPBSL
        vUDbOO36Lr4iFfaLFYI6jCW7nww0dw8=
X-Google-Smtp-Source: AK7set9L2FIpwGMGECLyskWfXlzU0H7sjRSGI9vrEuoVRE3jOXUP1tVhvhXXfg/VsQ8P5PxI02LV4EYJTec=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:b35d:3867:2eb8:33e4])
 (user=drosen job=sendgmr) by 2002:a5b:301:0:b0:a09:32fb:bd6c with SMTP id
 j1-20020a5b0301000000b00a0932fbbd6cmr4015876ybp.7.1677278190733; Fri, 24 Feb
 2023 14:36:30 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:36:26 -0800
In-Reply-To: <20220622194603.102655-1-krisman@collabora.com>
Mime-Version: 1.0
References: <20220622194603.102655-1-krisman@collabora.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230224223626.565126-1-drosen@google.com>
Subject: Re: [PATCH 0/7] Support negative dentries on case-insensitive directories
From:   Daniel Rosenberg <drosen@google.com>
To:     krisman@collabora.com
Cc:     ebiggers@kernel.org, jaegeuk@kernel.org, kernel@collabora.com,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These look good to me. It will be nice to have negative dentries back for
casefolded directories.

-Daniel Rosenberg
