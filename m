Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30E6FED06
	for <lists+linux-ext4@lfdr.de>; Thu, 11 May 2023 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjEKHjQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 May 2023 03:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbjEKHjP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 May 2023 03:39:15 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0FE6D
        for <linux-ext4@vger.kernel.org>; Thu, 11 May 2023 00:39:14 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1928ec49077so6591151fac.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 May 2023 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683790753; x=1686382753;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5az4Eu1VAlmeyQAupzgPEaWF28fGzbAd46Z1OgJ9gm4=;
        b=hPTYptZ1SvsuiDuZ+jQ5zBOua0snblfqrSTAHouFsR+cYSNWLJC3fvz+zEKNwlzzI8
         o3WMKEuz0+YorYhOn0xGZVZh+YJVkQ3VfLhUtn3MxYR8GC+Q4ergNYyofWLK+/awom8h
         bZSyBDZfrpoMeIZfvYfKreltrAYutXENiQgjiS0fvErLUL7sqmddUEMBDXCGDbdUkpk+
         rK0Eb9r2/lfUWgQzb2sJJ4X5176uju9CpPIhwd4/Mr2NUyBkmHr9VTJnO9F4gAQ8caX5
         3FIkrM9oaSYhKfEIgjXeSP5NJh2RCtoEmvsXwSeliCE3o1FdwpfmFqs2jvzaCtuvGMY4
         3eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683790753; x=1686382753;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5az4Eu1VAlmeyQAupzgPEaWF28fGzbAd46Z1OgJ9gm4=;
        b=Y+tY7Jd57OvCKRcGbzOYGaVKwnanUBZuh4W8c8oH6cfx3dO2SoVd0bnGcpo97HeT1T
         BIRXXEqXi6022IX5AFKKX+O7uqI1rUVNRaR0FlutmUYBnwCmQuSb9jdI6tg63bRvEQuY
         UbcUfGgSqSVNYjZBukBXoqTanpMH717rQVCOdodYNiKwOXGlnaaB7MojmDHjpZv1mUVb
         WGpCZsqotnn8OXH6d5QlqGxQc0GHXQx3z88yw1qNDHy656iEoAwd1qk1DN6lXA8rPzXZ
         iMsmg3TLT6NnboRUgIhXSH/S7aDCpMLnQ8wxSFq/qckMLLCA882kzUg0LZVIgyJUlk+F
         WKQQ==
X-Gm-Message-State: AC+VfDzL12pMVplmDIufIiN4+k2khuTQDi6JzXdDmMlQB4ERhhBL/m9Z
        +FdG/+rsrfrJqS8OIPnp6e2jR5j7jW9a52HHDsoRL4rXDBc=
X-Google-Smtp-Source: ACHHUZ45ukvYKI7P4hxsbYe6BH+BE/N2lNp9q+8+GnkfsfIhqDmQL1j4a+HoojlF0491LP7sfSBBAKBm7qxJibopKa0=
X-Received: by 2002:a05:6870:b146:b0:196:51e7:6454 with SMTP id
 a6-20020a056870b14600b0019651e76454mr2633055oal.51.1683790753255; Thu, 11 May
 2023 00:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <CABoTn5RSYDeYBnOd9w4DO1nnW4r6bN8WQ2an2-YK4MSgCk1eDw@mail.gmail.com>
In-Reply-To: <CABoTn5RSYDeYBnOd9w4DO1nnW4r6bN8WQ2an2-YK4MSgCk1eDw@mail.gmail.com>
From:   Oscar Megia <megia.oscar@gmail.com>
Date:   Thu, 11 May 2023 09:38:37 +0200
Message-ID: <CABoTn5Szn33VDPuNmJ+5__ZJmGFDQgsHLHXkA0KAvw9MHbvHyA@mail.gmail.com>
Subject: I know you are busy, but have you found time to look at my patch?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

My patch was: e2fsck: Add percent to files and blocks feature.

Do I need to change something or is it not accepted?

Regards
Oscar Megia L=C3=B3pez
