Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8033180D
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Mar 2021 21:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCHUCc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Mar 2021 15:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhCHUCX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Mar 2021 15:02:23 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76AC06174A
        for <linux-ext4@vger.kernel.org>; Mon,  8 Mar 2021 12:02:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o10so7129557pgg.4
        for <linux-ext4@vger.kernel.org>; Mon, 08 Mar 2021 12:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5+KRHSh3GEC8ILOOPT4wMGlaFztgka8nVLbkrx4pNso=;
        b=eoMTCEq0Ab/RxaPh6cfPnnYOXdyxdEYmYQV6qi4WKFVi8f0gQqKIctT4d9q3MHFFWp
         mYgcmR5J3etP1e2E8rx8jvnPoZLJrxpoIU3yESxV8jPymEve+XfHyo98XAp9jvBq8QI8
         1CUhiwvvwKSTO+ILwWmd4b5StDYpcjCQv32rT14seuHF0K1lqjVjEFafSJO1cl3UgHQm
         +ZzCjbIXKWfR5B9rYVpNDAZB9+eh/CH5Rqq1QcHDDj5EAwDLCgOEmP28EWRWn85tFROI
         yEPWpvS5viYX8NmgemAmlHbxRbtT9jccJpGbmsKCYP0dLDvwK4ZbqWlof88lR8DQUxM0
         MGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5+KRHSh3GEC8ILOOPT4wMGlaFztgka8nVLbkrx4pNso=;
        b=hc5PpO3yTggCDfMTfzB4RZNUbacjP+MuhIrts5q9pu4e9SBV5i5rmL6YdqGKPh80nK
         5Ng6zHfWRfimP0APYYm8kBUF6PTdScTxUSvMLsH71z6XCDiRrqF7vizj1BLxCS1T5vSA
         vcQ6G+7Vnb+PS8UPi8/6/ZY+1po/VFMhA2G0MAWp7iAlDoxmCOpjxm6ma8zdrZ2McZi7
         ndpm3BwZDA/8LHdkR/MMtiAVqi0rYW8LA0PK5R3/Fozo2LJ45jZkFqF/GzF4d/45b6l6
         643kJV0ZznXG2svKsMPmv6JAFj69VkvKQjGeGTSh/M8cXo9gAOWBzsE8NnVgQBEB/oFd
         1Sxw==
X-Gm-Message-State: AOAM5313S5A6X11G9gEB9Syp0p0cTqK6xy41QZ6JJ5JmhIOHw+sufadf
        jN8Z/8E6/jiilzVaM4I1Ydp/xTvjbDX9bSaQhlYx0Li20OI=
X-Google-Smtp-Source: ABdhPJzGuBx0awYdC5oQiDKxgrRO3YhOWz//iDAQ5tAxuvLJ/0elAG2STcnJnDmb9z32zx6M0j2JvQFcA7nLkAz8IMs=
X-Received: by 2002:a62:8811:0:b029:1ef:2105:3594 with SMTP id
 l17-20020a6288110000b02901ef21053594mr21559642pfd.70.1615233743074; Mon, 08
 Mar 2021 12:02:23 -0800 (PST)
MIME-Version: 1.0
From:   George Goffe <grgoffe@gmail.com>
Date:   Mon, 8 Mar 2021 12:01:46 -0800
Message-ID: <CALCFxS7EwQbF47GNgaiuOVrw0n=OQBzHTH6JpoeiZ=tb1CYB1g@mail.gmail.com>
Subject: Scrubbing filenames from meta-data dump of ext4 filesystems
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Howdy,

I'm helping to shoot a bug on a Fedora Core 35 system and have been
requested to provide a meta-data dump of the problem filesystem. The
filenames are restricted so I need to scrub this file  before sending
it.

Does ext4 have a facility whereby I can scrub the filenames from the dump?

Your help is appreciated.

Best regards,

George...


-- 
It's not what you know that hurts you, it's what you KNOW that AINT
so. WIll Rodgers
