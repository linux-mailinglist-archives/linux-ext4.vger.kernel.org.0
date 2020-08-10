Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134D62400A4
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHJBCd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36799 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgHJBCc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:32 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCs-000729-NQ
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:30 +0000
Received: by mail-qt1-f197.google.com with SMTP id z20so6448878qti.21
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zh8Gwm93bUEvdlOjX485mWlaq7SOnY486J0BpwJB8VU=;
        b=S2Rb8KY55goraKGbnkDnWbnBoYeSZib0cCBTsWEQwwsQoIiNteMoj+uwBNIVopYNoJ
         Hev+o0cKwqsGyYxV4bnqlkuwcyikrEUrWDLKXdcQU2xAN8Kk3oFaYMZZ2fQ5s/gRGuOu
         3E8vnQVw6R2HorHsw3D8vnJdq+IGialTtNqDcEyd5DVH8RB2F4zfmQlL79Q5yzJSQiH7
         +v+GaOSW0j8KfbqAUuTFPIuR3wkWh3CGJ1oXxOh7lK/pbDxEMhzj0i6YTDDpeo7Ibs5y
         KfVJtBSqAtVfWwXuBG/G8HNAT8Lo5fGq5SX21EswH+VGFVixvfH9w41upmxw/0CIfQs8
         Nv0w==
X-Gm-Message-State: AOAM532vb/gug91di/dbht1O9VSOyCbMRnH2HN+v3vxDEgTYbNzmhcsG
        04BRRf6cCq2qC7hNSaWP+YL9XdTe+q0DOQfsDFcsC4pZIoOqj9iMQLNUJw5KLr3QeAtRIVz3F07
        3+FfKCSP2cP/HOiGRafnK2pO1hXJQdZrl8FYL4XI=
X-Received: by 2002:a0c:ffa1:: with SMTP id d1mr25425436qvv.36.1597021349888;
        Sun, 09 Aug 2020 18:02:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjPgWx21PoPPWodqP9CyXksWm3STtK77ppfHtT38Ti5pkMtbmNjN+GNHeqH5WnnK9VueTK3Q==
X-Received: by 2002:a0c:ffa1:: with SMTP id d1mr25425416qvv.36.1597021349710;
        Sun, 09 Aug 2020 18:02:29 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:29 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2/SETUP SCRIPT]
Date:   Sun,  9 Aug 2020 22:02:09 -0300
Message-Id: <20200810010210.3305322-7-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#!/bin/sh
set -ex

IMG=$HOME/ext4.img
MNT=/ext4

if [ "$1" != 'mount' ]; then
	rm -f $IMG
	truncate --size 128M $IMG
fi

DEV=$(sudo losetup --find --show $IMG)

if [ "$1" != 'mount' ]; then
	sudo mkfs.ext4 $DEV
	sudo tune2fs -f -o journal_data $DEV
fi

sudo mkdir -p $MNT
sudo mount -o data=journal $DEV $MNT
sudo chown -R ubuntu:ubuntu $MNT
