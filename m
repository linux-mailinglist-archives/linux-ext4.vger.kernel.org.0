Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259DE79DE19
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 04:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjIMCMP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 22:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbjIMCMO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 22:12:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB07170B
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:12:10 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-655de2a5121so22612446d6.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571130; x=1695175930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5lDV9LjddUeh7Xv3bK22WOy8oqI4Udt1N/7UqzzxWk=;
        b=oULliiqU6MlAbYtyWIli3RCYS7H4K38rE8eMFqg89vH7QknQNRD/adIx7VVchM2UDi
         bl5FrODgsDgZox85MWfPhB4k+XHQdqwziTpaO2TIXnDCS/BZtgR6gB+rRQOUsQlHFUn/
         F9Ugzj/+vvDF/ZxrQWykJ4lM0f6YNNzt3b/+2IjAS2UMqZewcqbCn2KqTt+1tQvySIYi
         1v2GUyrPQ+2BKNyPzjP9Um9FuJv/MbM2+A1fk48ZNvdpTL3xAVb2N8ugGW2qTknEFpJO
         BbNv4jrQFTeH9mJAuXQmkhby/lTC6e+kKMxSvlEbhx+0RoS5FtXd0SUKdq3ctctvK+NU
         GlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571130; x=1695175930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5lDV9LjddUeh7Xv3bK22WOy8oqI4Udt1N/7UqzzxWk=;
        b=v3CltzRf4EvRndBd0SSrbNoKY6CEePR7sB95bS59Mwnp6aGjYmJW8LOUGwzTBp6C8S
         6BWL8vVOxulhI5ndRNyHs9EeKN8L9xPBzM7QPtsfOms9g2RGNnITODbSVZq89TtD+KUf
         HmVAnI1CyyqWMkp/Km+vPQred6U66W6WWEXA2FI7ga2jebMqqCP32k24S85zUhhKM9Mu
         Ey/oGOX8T5ZnJZqzAXkmT5l/kqaoo3VAz6/yzRF9s/sJUTygz6hOpLpC7UK1SoOCMLw/
         sWMSMKwJMZmFvzovrhFdYI8w4ZUTjxN99cXQq4PnqpnSFFPt4kzc5LekWhLMpYnA+3LA
         pnKA==
X-Gm-Message-State: AOJu0YzGMxakh6iNDEXr6OqZXoaKnv6EIgdF0FGeWm/x3bSUbNfWcHT4
        UCUpAYvf9qT1reujQNVTpqcoxk9siP4=
X-Google-Smtp-Source: AGHT+IExwTKW5Cbgwi2co+bXUIP13FgOJDjf5IJ0Mjbq4Crq+AAA3pgq1zmUvs4US5Pyy1glatMbMw==
X-Received: by 2002:ad4:5bc8:0:b0:64f:60ec:1102 with SMTP id t8-20020ad45bc8000000b0064f60ec1102mr1603319qvt.33.1694571129580;
        Tue, 12 Sep 2023 19:12:09 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b0064f778c8165sm4016055qvm.64.2023.09.12.19.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:12:09 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 0/6] improve cluster and block removal code
Date:   Tue, 12 Sep 2023 22:11:42 -0400
Message-Id: <20230913021148.1181646-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series cleans up and rewrites parts of the code used to free
clusters or blocks when space is removed from a file.  The intent is to
improve the readability, clarity, and efficiency of that code.  These
changes do not fix any known bugs.

Eric Whitney (6):
  ext4: consolidate code used to free clusters
  ext4: rework partial cluster definition and related tracepoints
  ext4: rework partial cluster handling to use lblk more consistently
  ext4: consolidate partial cluster initialization
  ext4: simplify and improve efficiency of cluster removal code
  ext4: remove mballoc's NOFREE flags

 fs/ext4/ext4.h              |   4 +-
 fs/ext4/ext4_extents.h      |  19 +-
 fs/ext4/extents.c           | 371 ++++++++++++++++++------------------
 fs/ext4/mballoc.c           |  25 +--
 include/trace/events/ext4.h | 123 ++++++++----
 5 files changed, 287 insertions(+), 255 deletions(-)

-- 
2.30.2

