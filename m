Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1402BDAD
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 05:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfE1DXF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 May 2019 23:23:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46126 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfE1DXF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 May 2019 23:23:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F4D760A33; Tue, 28 May 2019 03:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559013785;
        bh=0DXkyu6KcySRRZeJSMeiWC0oNTDOHseKmzmI9ky9x3s=;
        h=Date:From:To:Cc:Subject:From;
        b=cLlkqsVDZkHg5BiAEReTQrA+h98lYGgJOrXPeeFbQWb3OA+gEennXoo1ZObs8pmMA
         wSzXMfI0fZbKFzBoUv+czpADPAxzHUr04Ik8LRdk9OTtbOzVJMA61i3RWTrOSnqtvD
         j4IEl+PUuT3Cv8PQ5AAtcx1h2W9Oo/HjcRN8MNh0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D52D56070D;
        Tue, 28 May 2019 03:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559013782;
        bh=0DXkyu6KcySRRZeJSMeiWC0oNTDOHseKmzmI9ky9x3s=;
        h=Date:From:To:Cc:Subject:From;
        b=dibFKcF5HifY+3BK8yiemTGNalU3a6iUb/FYvZRe5cAOnRtjzDKaTQic5m2rV+tMR
         3IIXz5e87Cl9jak3zQeTAzf5cLM1GNAELp30FHsiB+Wse8EaBKbTazTpDkt7QGRu0f
         866+h6+b4Z/0+Z2hJhRgMynW5yRcYEQVrZ5Ufyjc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D52D56070D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 28 May 2019 08:52:57 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     stummala@codeaurora.org
Subject: fsync_mode mount option for ext4
Message-ID: <20190528032257.GF10043@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted, Andreas,

Do you think this mount option "fsync_mode=nobarrier"
can be added for EXT4 as well like in F2FS? Please
share your thoughts on this.

https://lore.kernel.org/patchwork/patch/908934/

Thanks,
Sahitya.
-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
