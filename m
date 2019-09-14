Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EACB2C86
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfINSGT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 14:06:19 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40764 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfINSGT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 14:06:19 -0400
Received: by mail-ed1-f41.google.com with SMTP id v38so29691501edm.7
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zomg-hu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=vn88cypXdSaHDCo8yJW8wZZqfPBMqq5FZAXxIrSIGPI=;
        b=T6o/Znu3tki6wR2EUnpa20566H57JYBYiWj2+wIN+ZXLJlQ8angcBh1cr50r6mY2dF
         t7fMUDdHbqMrCLkFZalG1DmUfoatWL9dsfFEANmqWuCOKKdtRij0MIEepx90IZrz7w+w
         ZJL7Sne8/etSaCIbuSGnV9xuAfyoYAaZwB3eiQfkNUyQzD2Qfg3eiHKdyT51ZBeG8Hg4
         E281d/Zs9/Llj6R/y8MJ+0BYM7TEC0+JP3X00APyQFgvVxHyA3ykyOX2QHX1ez931RIy
         oWW7iQXk2aFyYf4Bu2hiV/HqUN9shE3ftvTXJble28KftujJXowMc1IfoMdGBOcclD9y
         hi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vn88cypXdSaHDCo8yJW8wZZqfPBMqq5FZAXxIrSIGPI=;
        b=eNuxt2Hzi/DuZ3J9Mreh4AhtdcUdv72BT3hRo4oobJe6y+KCXOsil3OkkcOkS9iCij
         mDq9ksTyLGRXCs4zNeFXtbfrP1IPaxcoQBbsMEnpCd7ac8ifVKr5xVjvndiBNpD+UQx9
         yK7oMpdtmp+u2USHqisxo21bIlm6WFL8dJrG1me3AjLgOZ8upgpg+CFtigHWD2f7Bkgo
         4ZxhqWM5XWvVtx4JL+NtcJCwRDe3PRq/C9Yf8F+mtnIzcAGMFzWpm3CP5enx6vsfiquz
         Q5rAOeYQejhXBC4CGtxZXU6jePsLPq6PdjQ/EmHJ51tp6J8YmTyyx7e0tziRoRagqoZ5
         ARMg==
X-Gm-Message-State: APjAAAXrJQySOIOmmVB6PWLHSnWTyy/+Gm6BcTI7ZyOiR6iZmUWAGNta
        xj7Qv1CLjKZ+dRGMJoaHeor1JfN2fWIeUpYMblukA1rnTE8=
X-Google-Smtp-Source: APXvYqwijyTRD8S25J7n/pgel3Uj1bgr6NzAnOHnsmsCpMOk1F+wpebZwqGL50HN2gBkMx2y2ZFhhhSMJAUlp/w8Tn0=
X-Received: by 2002:aa7:ccda:: with SMTP id y26mr53779148edt.303.1568484376147;
 Sat, 14 Sep 2019 11:06:16 -0700 (PDT)
MIME-Version: 1.0
From:   Pas <pas@zomg.hu>
Date:   Sat, 14 Sep 2019 20:06:04 +0200
Message-ID: <CAF1H-TADHtpDtdL++Vk1FLAL7jJbOOifnN+7taDXpVkjYrbsgA@mail.gmail.com>
Subject: inline_data status (e2fsprogs)
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I hope this is the correct forum to ask these questions. (If not, then
sorry for the noise! Though then could you recommend where to ask
them?)


Is there any reason that inline_data is not a default enabled feature?
(The default inode size is already 256.
https://github.com/tytso/e2fsprogs/blob/dc5433647cb79bf1e7660f441c64330b3b8757cc/misc/mke2fs.conf.in#L14
)

Also, any particular reason that tune2fs cannot enable this feature?
("Setting filesystem feature 'inline_data' not supported.")

Finally, what are the dangers of using debugfs to enable the feature
flag? (As suggested here https://unix.stackexchange.com/a/309260/4003
)

Thanks,
Pas
