Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FE147890
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jan 2020 07:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAXG27 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jan 2020 01:28:59 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:42397 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXG27 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jan 2020 01:28:59 -0500
Received: by mail-pl1-f173.google.com with SMTP id p9so352726plk.9
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jan 2020 22:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TvMTOu3u9/EJC+0QH2LMtc/i6F6z1n2ouZ7Un7n3JDQ=;
        b=SJO7fIB0MRPM7b5gApwMK+DUgDyh9zfZ7WveB1dN+n73mJnG2h3wB/ZpMnniyiYSF0
         9Gk7LnLZvC+gAk8hhMoaUKbFIHNldFQe+aDnUkGZ5ImavOAa/zxr4CQ6wcOyd5O5owrT
         YxiTPrzTzC7wgRrhGboH4c8xffxHkZ3JiMQr7ZwRElgj5aqIplxHbiECqCe3quNs4LOL
         tEe82W2ttCyPNdT1eSLuc+otqOIgLatE107qTVhQxOG4iMBoMNhwglFcu5/XUCHcRSFf
         0ZwigXwM7DvDfCsdRDL07KWw6KBFjOZ49VOHFOo6U7zArXAj+6VBEti/LbXaNvPVDSNa
         LTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TvMTOu3u9/EJC+0QH2LMtc/i6F6z1n2ouZ7Un7n3JDQ=;
        b=e63J4boQFmd7o+/6KVHKu+tINFQbl9iORHpOTJoTLAlHWBIKpfllbWLoPgozaJtK98
         tEtu7vpy7BG81iQl1q7/+dddkQucxrAkE5jmlrTrcLVIXzq02M9wrNPL6LH11V+9P9Oh
         3naZ4dysPOIc284rDSJFHUxktiUKT51nTFk9ESZG1eEW3x6wA98tRqwHCOLGtomy9wC0
         ZgdcAFVTXHtXXanvZAJ9Qveexkwg1l4suRhiyv2HqaqIxupMmzTe5g0uqic3H5ZRQpPa
         SVEpixaYT1XTWk7OCQlKWCLmoWGYLKLgVmqmwo3QltF0qGuc2h+gfYZ3bXRkiJlMt6uJ
         2SvQ==
X-Gm-Message-State: APjAAAW9B14zBugqtVFJPMQAgEhpO1wan0sj8HprDShyxFukUG1ahDYO
        VgDavyIQoRMSv0FQG5zf8Cq3aAGCwpJS0hnF52EwWkQo
X-Google-Smtp-Source: APXvYqwDB2ZfOF7XnOr8OOjt7yh93hTXKUUxT/j9t+TrBRIXTshoavlNjzR31uDSVsw2cCJN+ffKen0vJCEHfYK6GII=
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr1969328pln.225.1579847338664;
 Thu, 23 Jan 2020 22:28:58 -0800 (PST)
MIME-Version: 1.0
From:   Colin Zou <colin.zou@gmail.com>
Date:   Thu, 23 Jan 2020 22:28:47 -0800
Message-ID: <CACZyaBsCb7KxQce27C79WhD5BKekq4Gi4z_P4h_xYvQ8_zv26A@mail.gmail.com>
Subject: Help: ext4 jbd2 IO requests slow down fsync
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I used to run my application on ext3 on SSD and recently switched to
ext4. However, my application sees performance regression. The root
cause is, iosnoop shows that the workload includes a lot of fsync and
every fsync does data IO and also jbd2 IO. While on ext3, it seldom
does journal IO. Is there a way to tune ext4 to increase fsync
performance? Say, by reducing jbd2 IO requests?

Thanks,
Colin
