Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEEDFC980
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKNPFS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 10:05:18 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:40571 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNPFR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Nov 2019 10:05:17 -0500
Received: by mail-io1-f54.google.com with SMTP id p6so7121185iod.7
        for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2019 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=f/wIJTAWzP7BWBPgaDcjnq2tleElYVsx2gA/HJJd2ZQ=;
        b=Fet/xOUW7aK5hkWBkyRK/Fx6/bGMCI3Evj9sGjkkZ6AwxQP+OUpAcQnBvwJ+XGsx9H
         SJmzdinTCqSk2Nxs0fCsHUiM5jeKqC6R6NHRd8+AilPc9wrMMUmvvmGi1N56lyZ598kP
         OqIBsxd/2Iso7dRa2rRBJOPn6DNma2UugjzRmgpkDEBtr5R+HHsMTcp5Bg1gNbkq8MXZ
         LhzHmPF3UTmXwHvyUyue3c6TdZKs0e2NuTwS8y3qCNM2lUbHikeIz6XGfMxYMDoUcIpp
         sTq5uS4nuwWEqUjolygQsD1V4j3rAbRS5To4DieMzILovZT1WVQ/Uuy88+Do11RArBK3
         MFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f/wIJTAWzP7BWBPgaDcjnq2tleElYVsx2gA/HJJd2ZQ=;
        b=DE920ciqamF06kGg4hNvtqYUwt77GbjAuedHrbb0Hh1NAEjhrUIxK/wA/A7pobMosq
         /+WuNTJBZbTybk0p8Dzt21uU+McKobDnND/v3vMtacSDc4VQXgB06xb7bDc9tLBrhSMY
         t06zc22AqiNIokz024ijjEaKIOTFHdO/axCWzHjM2z20tKIiIcbuNmHOHiqUUt/PQqUc
         jp5dGnXOa68CesljSTV/mVjCjY1bXJzDt53UPMsPbGGEQ65/NXiPKAQna4iedcWs5GR/
         /yOfn5tClmV6dCE1cIvFf9geMay4oj4oDkrf/s8nMnw/N2AHZ5Nqyo3O8X//RlszeD4l
         PGVA==
X-Gm-Message-State: APjAAAVoqW5wnFCY3MOR1gFkRNP5MPFGGXWod9Uds9E+5LsstCIk9BOd
        vt9UJg0/VtEkUhfWE/cpWXaITgau4D3wXe2acxkaaDIkmMA=
X-Google-Smtp-Source: APXvYqxdV7wF6LaQ/Qd/Y9uGzFeMpYkRrajUhX6lCMwLBYu494ROSbJJx/caGoIUj74GAto4yYwT9yz7INtsnPQoEUc=
X-Received: by 2002:a5e:c649:: with SMTP id s9mr8583103ioo.194.1573743916774;
 Thu, 14 Nov 2019 07:05:16 -0800 (PST)
MIME-Version: 1.0
From:   Jesse Grodman <jgrodman@gmail.com>
Date:   Thu, 14 Nov 2019 17:05:06 +0200
Message-ID: <CACtp79ADncLAs560QNKCZtX937XaB6-37Xz2SYP7PyonJjRtwg@mail.gmail.com>
Subject: Suggested change for superblock journal hint
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I encountered the scenario that a full fsck check was being run
unnecessarily when the major / minor number of my external journal was
being fixed by fsck. This PR changes that so that this change does
trigger the full fsck run: github.com/tytso/e2fsprogs/pull/26

Jesse
